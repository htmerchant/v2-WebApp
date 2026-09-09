import streamlit as st
import pandas as pd
import requests
import re
from pathlib import Path

# ==============================================================================
# 1. APPLICATION SETUP & METADATA
# ==============================================================================
st.set_page_config(
    page_title="DETECT v2 Decision Support Tool",
    page_icon="🛡️",
    layout="wide",
    initial_sidebar_state="expanded"
)

st.title("🛡️ DETECT v2: Digital Engineering Ecosystem Model")
st.markdown("""
Interactive web application for the **DETECT v2 (Digital Engineering Ecosystem Sizing & Tailoring)** model. 
This tool dynamically evaluates **Use Case 1 (Sizing)**, **Use Case 2 (Lifecycle Phases)**, and **Use Case 3 (Job Series)** based on your SysML v2 definitions from [htmerchant/v2-WebApp](https://github.com/htmerchant/v2-WebApp).
This is an active beta-testing program while the sysmlv2 model is still in development.
""")
st.divider()

# ==============================================================================
# 2. HYBRID FILE LOADER (Local + GitHub Raw Fallback)
# ==============================================================================
GITHUB_RAW_BASE = "https://raw.githubusercontent.com/htmerchant/v2-WebApp/main"

@st.cache_data(show_spinner="Loading SysML v2 model definitions...")
def fetch_file_content(filename: str) -> str:
    """
    Checks for the file locally first. If not found locally, fetches directly
    from the GitHub repository main branch.
    """
    # Check local direct path and subdirectories
    for local_path in [Path(filename), Path("model_files") / filename, Path(".") / filename]:
        if local_path.exists() and local_path.is_file():
            return local_path.read_text(encoding="utf-8")
    
    # Fallback: Fetch from GitHub Raw
    url = f"{GITHUB_RAW_BASE}/{filename}"
    try:
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            return response.text
    except Exception as e:
        st.warning(f"Could not load {filename} from GitHub: {e}")
        
    return ""

# ==============================================================================
# 3. DYNAMIC SYSML v2 PARSING ENGINE
# ==============================================================================
@st.cache_data
def parse_sysml_definitions(raw_text: str):
    """
    Extracts all input boolean attributes and derived tool mappings from SysML v2 definitions.
    """
    if not raw_text:
        return [], {}

    # Extract all boolean input attributes
    inputs_block_match = re.search(r"item\s+inputs\s*\{(.*?)\}", raw_text, re.DOTALL)
    input_attributes = []
    if inputs_block_match:
        input_attributes = re.findall(r"attribute\s+([a-zA-Z0-9_]+)\s*:\s*Boolean", inputs_block_match.group(1))

    # Extract derived attributes and tool enumerations
    derived_pattern = re.compile(
        r"derived\s+attribute\s+\w+\s*:\s*Tool_Type_e\[\*\]\s*=\s*if\s+inputs\.([a-zA-Z0-9_]+)\s*\?\s*\((.*?)\)\s*else\s*null;",
        re.DOTALL
    )
    matches = derived_pattern.findall(raw_text)
    
    tool_mappings = {}
    for input_trigger, tool_block in matches:
        tools = re.findall(r"Tool_Type_e::'(.*?)'", tool_block)
        tool_mappings[input_trigger] = tools
        
    return input_attributes, tool_mappings

def format_display_name(raw_name: str) -> str:
    """Formats SysML attribute names to readable titles."""
    return raw_name.replace("phase_", "").replace("role_", "").replace("_", " ").title()

# Load definition files
lifecycle_raw = fetch_file_content("lifecycle_phase_defs.sysml") or fetch_file_content("lifecycle_phase_defs.sysml")
job_series_raw = fetch_file_content("job_series_defs.sysml") or fetch_file_content("job_series_defs.sysml")

lifecycle_inputs, lifecycle_mappings = parse_sysml_definitions(lifecycle_raw)
job_series_inputs, job_series_mappings = parse_sysml_definitions(job_series_raw)

# ==============================================================================
# 4. USER INTERFACE TABS
# ==============================================================================
tab_uc1, tab_uc2, tab_uc3, tab_summary = st.tabs([
    "📊 UC1: Ecosystem Sizing",
    "🔄 UC2: Tool Types by Lifecycle Phase",
    "👥 UC3: Tool Types by Job Series",
    "📑 Summary & Export"
])

# ------------------------------------------------------------------------------
# TAB 1: UC1 ECOSYSTEM SIZING
# ------------------------------------------------------------------------------
with tab_uc1:
    st.subheader("UC1: Determine DE Ecosystem Sizing")
    st.write("Configure the 10 core architectural parameters to compute ecosystem size:")
    
    sizing_options = {
        "number_of_users": ["1-100 (Small)", "100-1000 (Medium)", ">1000 (Large)"],
        "number_of_partners": ["0 / Regional (Small)", "1-5 (Medium)", ">5 (Large)"],
        "engineering_domains": ["<=2 (Small)", ">2 (Medium)", ">5 (Large)"],
        "geographic_locations": ["1 (Small)", "2-5 (Medium)", ">5 (Large)"],
        "lifecycle_phases": ["1-2 (Small)", "2 to 3 (Medium)", "All Phases (Large)"],
        "automation": ["Manual / Low Automation", "Moderate / Adoption of Autonomous Platforms", "Autonomous / Full Automation"],
        "enclaves": ["1-10 Enclaves", "11-50 Enclaves", "50+ Enclaves"],
        "tenants": ["Single App, Single DB", "Multi App, Single DB", "Multi App, Multi DB"],
        "project_deliverables": ["10s (Small)", "100s (Medium)", "1000s (Large)"],
        "storage": ["Gigabytes (Small)", "Terabytes (Medium)", "Petabytes (Large)"]
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

    total_score = sum(sizing_options[k].index(sizing_selections[k]) + 1 for k in keys)
    
    if total_score <= 17:
        size_result, size_badge = "Small", "🟢 Small"
    elif 18 <= total_score <= 28:
        size_result, size_badge = "Medium", "🟡 Medium"
    else:
        size_result, size_badge = "Large", "🔴 Large"

    st.success(f"### Sizing Classification: **{size_badge}** (Calculated Score: {total_score} / 30)")

# ------------------------------------------------------------------------------
# TAB 2: UC2 LIFECYCLE TOOL TYPES (Grouped by Lifecycle Phase)
# ------------------------------------------------------------------------------
with tab_uc2:
    st.subheader("UC2: Identify Tool Types by Lifecycle Phase")
    
    if not lifecycle_inputs:
        st.warning("No lifecycle phases parsed. Please ensure `lifecycle_phase_defs1.txt` is available.")
    else:
        st.write(f"Selecting from all **{len(lifecycle_inputs)}** lifecycle phases:")
        
        c_btn1, c_btn2, _ = st.columns([1, 1, 4])
        with c_btn1:
            select_all_lc = st.button("Select All Phases")
        with c_btn2:
            clear_all_lc = st.button("Clear All Phases")

        selected_phases = []
        num_cols = 3
        cols = st.columns(num_cols)
        
        for idx, phase in enumerate(lifecycle_inputs):
            default_val = True if clear_all_lc else False
            with cols[idx % num_cols]:
                if st.checkbox(format_display_name(phase), value=default_val, key=f"lc_{phase}"):
                    selected_phases.append(phase)
        
        st.divider()
        st.write("### 📋 Recommended Tool Types Grouped by Lifecycle Phase")
        
        if selected_phases:
            # Option A: Display as an Interactive Structured Table
            phase_table_rows = []
            for phase in selected_phases:
                tools = lifecycle_mappings.get(phase, [])
                phase_table_rows.append({
                    "Lifecycle Phase": format_display_name(phase),
                    "Tool Count": len(tools),
                    "Recommended Tool Categories": ", ".join(tools) if tools else "None specified"
                })
            
            st.dataframe(pd.DataFrame(phase_table_rows), use_container_width=True)
            
            # Option B: Clean Expandable View for Each Phase
            with st.expander("🔍 View Detailed Tool Breakdown per Phase", expanded=False):
                for phase in selected_phases:
                    tools = lifecycle_mappings.get(phase, [])
                    st.markdown(f"#### 🔹 {format_display_name(phase)}")
                    if tools:
                        for tool in tools:
                            st.markdown(f"- {tool}")
                    else:
                        st.write("*No specific tools required for this phase.*")
                    st.write("")
        else:
            st.info("No lifecycle phases selected. Please check at least one phase above to see results.")

        # Aggregate all unique lifecycle tools for summary export
        triggered_lifecycle_tools = set()
        for phase in selected_phases:
            triggered_lifecycle_tools.update(lifecycle_mappings.get(phase, []))

# ------------------------------------------------------------------------------
# TAB 3: UC3 JOB SERIES MAPPING (Grouped by Occupational Series)
# ------------------------------------------------------------------------------
with tab_uc3:
    st.subheader("UC3: Identify Tools by Job Series")
    
    if not job_series_inputs:
        st.warning("No job series parsed. Please ensure `job_series_defs1.txt` is available.")
    else:
        st.write(f"Selecting from all **{len(job_series_inputs)}** occupational series:")

        c_btn3, c_btn4, _ = st.columns([1, 1, 4])
        with c_btn3:
            select_all_js = st.button("Select All Roles")
        with c_btn4:
            clear_all_js = st.button("Clear All Roles")

        selected_roles = []
        num_cols_roles = 3
        cols_roles = st.columns(num_cols_roles)
        
        for idx, role in enumerate(job_series_inputs):
            default_val = True if clear_all_js else False
            with cols_roles[idx % num_cols_roles]:
                if st.checkbox(format_display_name(role), value=default_val, key=f"js_{role}"):
                    selected_roles.append(role)

        st.divider()
        st.write("### 📋 Recommended Tool Types Grouped by Job Series")

        if selected_roles:
            # Option A: Display as an Interactive Structured Table
            role_table_rows = []
            for role in selected_roles:
                tools = job_series_mappings.get(role, [])
                role_table_rows.append({
                    "Job Series / Role": format_display_name(role),
                    "Tool Count": len(tools),
                    "Required Tool Categories": ", ".join(tools) if tools else "None specified"
                })
            
            st.dataframe(pd.DataFrame(role_table_rows), use_container_width=True)

            # Option B: Clean Expandable View for Each Job Series
            with st.expander("🔍 View Detailed Tool Breakdown per Job Series", expanded=False):
                for role in selected_roles:
                    tools = job_series_mappings.get(role, [])
                    st.markdown(f"#### 👤 {format_display_name(role)}")
                    if tools:
                        for tool in tools:
                            st.markdown(f"- {tool}")
                    else:
                        st.write("*No specific tools mapped to this role.*")
                    st.write("")
        else:
            st.info("No job series selected. Please check at least one role above to see results.")

# ------------------------------------------------------------------------------
# TAB 4: SUMMARY & EXPORT
# ------------------------------------------------------------------------------
with tab_summary:
    st.subheader("📑 Final DETECT v2 Tailoring Summary")

    all_triggered_tools = set()
    if 'triggered_lifecycle_tools' in locals():
        all_triggered_tools.update(triggered_lifecycle_tools)
    if 'selected_roles' in locals():
        for role in selected_roles:
            all_triggered_tools.update(job_series_mappings.get(role, []))

    st.markdown(f"""
    * **Ecosystem Size:** **{size_result}** ({total_score} / 30 points)
    * **Active Lifecycle Phases:** {len(selected_phases) if 'selected_phases' in locals() else 0}
    * **Active Job Roles:** {len(selected_roles) if 'selected_roles' in locals() else 0}
    * **Consolidated Unique Tool Categories Required:** {len(all_triggered_tools)}
    """)
    
    st.write("#### Consolidated List of All Tool Categories:")
    if all_triggered_tools:
        st.json(sorted(list(all_triggered_tools)))
    else:
        st.info("No tool categories active based on current selections.")

    summary_df = pd.DataFrame({
        "System Size": [size_result],
        "Sizing Score": [total_score],
        "Selected Phases": ["; ".join(map(format_display_name, selected_phases))] if 'selected_phases' in locals() else [""],
        "Selected Roles": ["; ".join(map(format_display_name, selected_roles))] if 'selected_roles' in locals() else [""],
        "Consolidated Tool Categories": ["; ".join(sorted(list(all_triggered_tools)))]
    })
    
    csv_bytes = summary_df.to_csv(index=False).encode('utf-8')
    st.divider()
    st.download_button(
        label="📥 Download Full DETECT Tailoring Report (CSV)",
        data=csv_bytes,
        file_name="DETECT_v2_Tailoring_Report.csv",
        mime="text/csv"
    )