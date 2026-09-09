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
            attribute :>> phase_requirement_development = true;
            attribute :>> phase_analysis_of_alternatives = true;
            attribute :>> phase_contract_studies = true;

            // Category 2: Technology Maturity and Risk Reduction Phase (TMRR)
            attribute :>> phase_mature_requirements = true;
            attribute :>> phase_prototype_contracts = true;
            attribute :>> phase_prototyping = true;
            attribute :>> phase_preliminary_design_development = true; 
            attribute :>> phase_CDD_validation = true;
            attribute :>> phase_RFP_release_decision_development = true;

            // Category 3: Engineering and Manufacturing Development Phase (EMD)
            attribute :>> phase_development_contracts = true;
            attribute :>> phase_complete_system_design = true;
            attribute :>> phase_system_development = true;
            attribute :>> phase_developmental_testing = true;

            // Category 4: Production and Deployment Phase (P&D)
            attribute :>> phase_production_contracts = true;
            attribute :>> phase_low_rate_initial_production = true;
            attribute :>> phase_operational_testing = true;
            attribute :>> phase_full_rate_production_decision = true;
            attribute :>> phase_full_rate_production = true;
            attribute :>> phase_full_rate_production_deployment = true;

            // Category 5: Operation and Support Phase (O&S)
            attribute :>> phase_sustainment_contracts = true;
            attribute :>> phase_system_sustainment = true;

            // Category 6: All Phases
            attribute :>> phase_strategy_development = true;
            attribute :>> phase_technical_reviews = true;
            attribute :>> phase_cost_estimation_and_affordability = true;
            attribute :>> phase_program_management = true;
        }
    }
}
