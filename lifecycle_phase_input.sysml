package DETECT_Input_Lifecycle_Phases {
    doc
    /* User Input File for UC2.
     * Instructions: Set the boolean value to 'true' if your DE ecosystem 
     * needs to support that specific lifecycle phase.
     */

    private import DETECT_Lifecycle_Phases::*; 

    part ecosystem_tool_profile : Tool_Profile { 
        
        item :>> inputs {
            // Category 1: Materiel Solutions Analysis Phase (MSA)
            attribute :>> phase_requirement_development = false;
            attribute :>> phase_analysis_of_alternatives = false;
            attribute :>> phase_contract_studies = false;

            // Category 2: Technology Maturity and Risk Reduction Phase (TMRR)
            attribute :>> phase_mature_requirements = false;
            attribute :>> phase_prototype_contracts = false;
            attribute :>> phase_prototyping = false;
            attribute :>> phase_preliminary_design_development = false; 
            attribute :>> phase_CDD_validation = false;
            attribute :>> phase_RFP_release_decision_development = false;

            // Category 3: Engineering and Manufacturing Development Phase (EMD)
            attribute :>> phase_development_contracts = false;
            attribute :>> phase_complete_system_design = false;
            attribute :>> phase_system_development = false;
            attribute :>> phase_developmental_testing = false;

            // Category 4: Production and Deployment Phase (P&D)
            attribute :>> phase_production_contracts = false;
            attribute :>> phase_low_rate_initial_production = false;
            attribute :>> phase_operational_testing = false;
            attribute :>> phase_full_rate_production_decision = false;
            attribute :>> phase_full_rate_production = false;
            attribute :>> phase_full_rate_production_deployment = false;

            // Category 5: Operation and Support Phase (O&S)
            attribute :>> phase_sustainment_contracts = false;
            attribute :>> phase_system_sustainment = false;

            // Category 6: All Phases
            attribute :>> phase_strategy_development = false;
            attribute :>> phase_technical_reviews = false;
            attribute :>> phase_cost_estimation_and_affordability = false;
            attribute :>> phase_program_management = false;
        }
    }
}
