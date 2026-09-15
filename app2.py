import streamlit as st
import pandas as pd
import re
from pathlib import Path
import collections

# ==============================================================================
# 1. APPLICATION SETUP & CONFIGURATION
# ==============================================================================
st.set_page_config(
    page_title="DETECT v2 Decision Support Tool",
    page_icon="🛡️",
    layout="wide",
    initial_sidebar_state="expanded"
)

st.title("🛡️ DETECT v2: Digital Engineering Ecosystem Model")
st.markdown("""
This web application simulates the **SysML v2 DETECT v2** model. It dynamically parses the underlying SysML definition files to provide an organized, categorized user experience across all three primary use cases.
""")
st.divider()

# ==============================================================================
# 2. HIERARCHICAL SYSML v2 PARSING ENGINE
# ==============================================================================

@st.cache_data
def parse_sysml_definitions_hierarchical(file_path_str: str):
    """
    Parses a SysML definition file to extract a hierarchical structure of 
    categories and their input attributes, plus all derived tool mappings.
    """
    file_path = Path(file_path_str)
    if not file_path.exists():
        return None, None

    text = file_path.read_text(encoding='utf-8')
    
    # 1. Isolate the main 'inputs' block
    main_inputs_match = re.search(r"item\s+inputs\s*\{(.*)\}", text, re.DOTALL)
    if not main_inputs_match:
        return {}, {}
    
    main_inputs_block = main_inputs_match.group(1)
    
    # 2. Extract nested 'item "Category Name" { ... }' blocks with robust quotes support
    category_pattern = re.compile(r'item\s+["\'](.*?)["\']\s*\{(.*?)\}', re.DOTALL)
    category_matches = category_pattern.findall(main_inputs_block)
    
    structured_inputs = collections.OrderedDict()
    for cat_name, cat_block in category_matches:
        attribute_pattern = re.compile(r"attribute\s+([a-zA-Z0-9_]+)\s*:\s*Boolean")
        attributes = attribute_pattern.findall(cat_block)
        if attributes:
            structured_inputs[cat_name.strip()] = attributes

    # 3. Resolve derived attributes to their matching mappings
    derived_pattern = re.compile(
        r"derived\s+attribute\s+\w+\s*:\s*Tool_Type_e\[\*\]\s*=\s*if\s+inputs\.([a-zA-Z0-9_\" \.\(\)\&\-]+)\s*\?\s*\((.*?)\)\s*else\s*null;",
        re.DOTALL
    )
    matches = derived_pattern.findall(text)
    
    tool_mappings = {}
    for input_trigger, tool_block in matches:
        clean_trigger = input_trigger.split('.')[-1].strip('"\t ')
        tools = re.findall(r"Tool_Type_e::'(.*?)'", tool_block)
        tool_mappings[clean_trigger] = tools
        
    return structured_inputs, tool_mappings

def format_display_name(raw_name: str) -> str:
    """Formats SysML attribute identifiers into human-readable labels."""
    return raw_name.replace("phase_", "").replace("role_", "").replace("_", " ").title()

# ==============================================================================
# 3. LOAD & CACHE MODEL DATA
# ==============================================================================

BASE_PATH = Path("model_files")
LIFECYCLE_DEFS_PATH = BASE_PATH / "lifecycle_phase_defs.sysml"
JOB_SERIES_DEFS_PATH = BASE_PATH / "job_series_defs.sysml"

# Gracefully support root directory placement as fallback
if not LIFECYCLE_DEFS_PATH.exists():
    LIFECYCLE_DEFS_PATH = Path("lifecycle_phase_defs.sysml")
if not JOB_SERIES_DEFS_PATH.exists():
    JOB_SERIES_DEFS_PATH = Path("job_series_defs.sysml")

lifecycle_inputs_structured, lifecycle_mappings = parse_sysml_definitions_hierarchical(str(LIFECYCLE_DEFS_PATH))
job_series_inputs_structured, job_series_mappings = parse_sysml_definitions_hierarchical(str(JOB_SERIES_DEFS_PATH))

if lifecycle_inputs_structured is None or job_series_inputs_structured is None:
    st.error("⚠️ Failed to locate model definition files. Ensure `lifecycle_phase_defs1.txt` and `job_series_defs1.txt` exist.")
    st.stop()

# ==============================================================================
# 4. USER INTERFACE TABS
# ==============================================================================
tab_uc1, tab_uc2, tab_uc3, tab_summary = st.tabs([
    "📊 UC1: Ecosystem Sizing",
    "🔄 UC2: Lifecycle Tool Types",
    "👥 UC3: Job Series Mapping",
    "📑 Summary & Export"
])

# ------------------------------------------------------------------------------
# TAB 1: UC1 SIZING
# ------------------------------------------------------------------------------
with tab_uc1:
    st.subheader("UC1: Determine DE Ecosystem Sizing")
    st.write("Configure the 10 core architectural parameters to calculate the system size:")
    
    sizing_options = {
        "number_of_users": ["1-100", "100-1000", ">1000"],
        "number_of_partners": ["0 (regional)", "1-5", ">5"],
        "engineering_domains": ["<=2", ">2", ">5"],
        "geographic_locations": ["1", "2-5", ">5"],
        "lifecycle_phases": ["1-2", "3-4", "All 5"],
        "automation": ["Manual, Low Automation", "Moderate, Adoption of autonomous platforms", "Autonomous, Enterprise-Level, Full Automation"],
        "enclaves": ["1-10 enclaves", "11-50 enclaves", "50 + enclaves"],
        "tenants": ["Single application, single DB", "Multi application, single DB", "Multi application, multi DB"],
        "project_deliverables": ["10s", "100s", "1000s"],
        "storage": ["Gigabytes", "Terabytes", "Petabytes"]
    }
    
    col1, col2 = st.columns(2)
    sizing_selections = {}
    keys = list(sizing_options.keys())
    
    with col1:
        for key in keys[:5]:
            sizing_selections[key] = st.selectbox(format_display_name(key), sizing_options[key], index=1)
    with col2:
        for key in keys[5:]:
            sizing_selections[key] = st.selectbox(format_display_name(key), sizing_options[key], index=1)

    total_score = sum(sizing_options[key].index(val) + 1 for key, val in sizing_selections.items())
    
    if total_score <= 17:
        size_result, size_color = "Small", "🟢"
    elif 18 <= total_score <= 28:
        size_result, size_color = "Medium", "🟡"
    else:
        size_result, size_color = "Large", "🔴"

    st.success(f"### Sizing Result: {size_color} **{size_result} Ecosystem** (Total Score: {total_score} / 30)")

# ------------------------------------------------------------------------------
# TAB 2: UC2 LIFECYCLE TOOL TYPES (Categorized with Expanders)
# ------------------------------------------------------------------------------
with tab_uc2:
    st.subheader("UC2: Identify Tool Types by Lifecycle Phase")
    st.write("Select active lifecycle phases, organized by phase category:")

    selected_phases = []
    
    for category, phases in lifecycle_inputs_structured.items():
        with st.expander(f"📁 **{category}** ({len(phases)} phases)", expanded=True):
            num_cols = 3
            cols = st.columns(num_cols)
            for i, phase in enumerate(phases):
                with cols[i % num_cols]:
                    if st.checkbox(format_display_name(phase), value=True, key=f"phase_{phase}"):
                        selected_phases.append(phase)
    
    st.divider()
    st.write("### 📋 Recommended Tool Types Grouped by Lifecycle Phase")
    
    if selected_phases:
        phase_table_rows = []
        for p in selected_phases:
            tools = lifecycle_mappings.get(p, [])
            cat_found = next((cat for cat, p_list in lifecycle_inputs_structured.items() if p in p_list), "General")
            phase_table_rows.append({
                "Category": cat_found,
                "Lifecycle Phase": format_display_name(p),
                "Tool Count": len(tools),
                "Recommended Tool Categories": ", ".join(tools) if tools else "None specified"
            })
        st.dataframe(pd.DataFrame(phase_table_rows), use_container_width=True)
    else:
        st.info("No lifecycle phases selected.")

# ------------------------------------------------------------------------------
# TAB 3: UC3 JOB SERIES MAPPING (Categorized with Expanders)
# ------------------------------------------------------------------------------
with tab_uc3:
    st.subheader("UC3: Identify Tools by Job Series")
    st.write("Select active occupational roles, organized by job series category:")

    selected_roles = []
    
    # Render each job category dynamically inside a dedicated Streamlit expander
    for category, roles in job_series_inputs_structured.items():
        with st.expander(f"👥 **{category}** ({len(roles)} roles)", expanded=True):
            num_cols_roles = 3
            cols_roles = st.columns(num_cols_roles)
            for i, role in enumerate(roles):
                with cols_roles[i % num_cols_roles]:
                    # Renders inputs dynamically under the correct group header
                    if st.checkbox(format_display_name(role), value=True, key=f"role_{role}"):
                        selected_roles.append(role)
    
    st.divider()
    st.write("### 📋 Recommended Tool Types Grouped by Job Series")
    
    if selected_roles:
        role_table_rows = []
        for r in selected_roles:
            tools = job_series_mappings.get(r, [])
            cat_found = next((cat for cat, r_list in job_series_inputs_structured.items() if r in r_list), "General")
            role_table_rows.append({
                "Category": cat_found,
                "Job Series / Role": format_display_name(r),
                "Tool Count": len(tools),
                "Recommended Tool Categories": ", ".join(tools) if tools else "None specified"
            })
        st.dataframe(pd.DataFrame(role_table_rows), use_container_width=True)
    else:
        st.info("No job series selected.")

# ------------------------------------------------------------------------------
# TAB 4: SUMMARY & EXPORT
# ------------------------------------------------------------------------------
with tab_summary:
    st.subheader("📑 Final DETECT v2 Tailoring Summary")

    # Aggregate tool categories safely
    triggered_lifecycle_tools = {tool for phase in selected_phases for tool in lifecycle_mappings.get(phase, [])}
    final_tool_set = triggered_lifecycle_tools.copy()
    for role in selected_roles:
        final_tool_set.update(job_series_mappings.get(role, []))

    st.markdown(f"""
    - **System Size Classification:** **{size_result}** (Score: {total_score} / 30)
    - **Active Lifecycle Phases:** {len(selected_phases)}
    - **Active Occupational Roles:** {len(selected_roles)}
    - **Total Unique Tool Categories Required:** {len(final_tool_set)}
    """)
    
    st.write("#### Consolidated List of All Recommended Tool Categories")
    if final_tool_set:
        st.json(sorted(list(final_tool_set)))
    else:
        st.info("No tools recommended based on current selections.")

    summary_df = pd.DataFrame({
        "System Size": [size_result],
        "Sizing Score": [total_score],
        "Selected Phases": ["; ".join(map(format_display_name, selected_phases))],
        "Selected Roles": ["; ".join(map(format_display_name, selected_roles))],
        "Consolidated Tool Categories": ["; ".join(sorted(list(final_tool_set)))]
    })
    
    csv_data = summary_df.to_csv(index=False).encode('utf-8')
    st.divider()
    st.download_button(
        label="📥 Download Full Tailoring Report (CSV)",
        data=csv_data,
        file_name="DETECT_v2_Tailoring_Report.csv",
        mime="text/csv"
    )