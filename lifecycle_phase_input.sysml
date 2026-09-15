package DETECT_Input_Lifecycle_Phases {
    doc
    /* User Input File for UC2.
     * Instructions: Set the boolean value to 'true' if your DE ecosystem 
     * needs to support that specific lifecycle phase.
     */

    private import DETECT_Lifecycle_Phases::*; 

    part ecosystem_tool_profile : Tool_Profile { 
        
        item :>> inputs {

            attribute :>> 'Category 1: Materiel Solutions Analysis Phase (MSA)'.phase_requirement_development = false;
            attribute :>> 'Category 1: Materiel Solutions Analysis Phase (MSA)'.phase_analysis_of_alternatives = false;
            attribute :>> 'Category 1: Materiel Solutions Analysis Phase (MSA)'.phase_contract_studies = false;

            attribute :>> 'Category 2: Technology Maturity and Risk Reduction Phase (TMRR)'.phase_mature_requirements = false;
            attribute :>> 'Category 2: Technology Maturity and Risk Reduction Phase (TMRR)'.phase_prototype_contracts = false;
            attribute :>> 'Category 2: Technology Maturity and Risk Reduction Phase (TMRR)'.phase_prototyping = false;
            attribute :>> 'Category 2: Technology Maturity and Risk Reduction Phase (TMRR)'.phase_preliminary_design_development = false; 
            attribute :>> 'Category 2: Technology Maturity and Risk Reduction Phase (TMRR)'.phase_CDD_validation = false;
            attribute :>> 'Category 2: Technology Maturity and Risk Reduction Phase (TMRR)'.phase_RFP_release_decision_development = false;

            attribute :>> 'Category 3: Engineering and Manufacturing Development Phase (EMD)'.phase_development_contracts = false;
            attribute :>> 'Category 3: Engineering and Manufacturing Development Phase (EMD)'.phase_complete_system_design = false;
            attribute :>> 'Category 3: Engineering and Manufacturing Development Phase (EMD)'.phase_system_development = false;
            attribute :>> 'Category 3: Engineering and Manufacturing Development Phase (EMD)'.phase_developmental_testing = false;

            attribute :>> 'Category 4: Production and Deployment Phase (P&D)'.phase_production_contracts = false;
            attribute :>> 'Category 4: Production and Deployment Phase (P&D)'.phase_low_rate_initial_production = false;
            attribute :>> 'Category 4: Production and Deployment Phase (P&D)'.phase_operational_testing = false;
            attribute :>> 'Category 4: Production and Deployment Phase (P&D)'.phase_full_rate_production_decision = false;
            attribute :>> 'Category 4: Production and Deployment Phase (P&D)'.phase_full_rate_production = false;
            attribute :>> 'Category 4: Production and Deployment Phase (P&D)'.phase_full_rate_production_deployment = false;

            attribute :>> 'Category 5: Operation and Support Phase (O&S)'.phase_sustainment_contracts = false;
            attribute :>> 'Category 5: Operation and Support Phase (O&S)'.phase_system_sustainment = false;

            attribute :>> 'Category 6: All Phases'.phase_strategy_development = false;
            attribute :>> 'Category 6: All Phases'.phase_technical_reviews = false;
            attribute :>> 'Category 6: All Phases'.phase_cost_estimation_and_affordability = false;
            attribute :>> 'Category 6: All Phases'.phase_program_management = false;
        }
    }
}
