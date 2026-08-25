package DETECT_Input_Tool_Types {
    doc
    /* User Input File for UC2.
     * Instructions: Set the boolean value to 'true' if your DE ecosystem 
     * needs to support that specific lifecycle phase.
     */

    private import DETECT_Tool_Types::*; 

    part ecosystem_tool_profile : DETECT_Tool_Types::Tool_Profile { 
        
        item :>> inputs {
            // Category 1: Materiel Solutions Analysis Phase (MSA)
            attribute :>> phase_development_requirements = true;
            attribute :>> phase_analysis_of_alternatives = true;
            attribute :>> phase_study_contracts = true;

            // Category 2: Technology Maturity and Risk Reduction Phase (TMRR)
            attribute :>> phase_mature_rqts = true;
            attribute :>> phase_proto_contr = true;
            attribute :>> phase_prototyping = true;
            attribute :>> phase_dev_prel_design = true; 
            attribute :>> phase_cdd_validation = true;
            attribute :>> phase_dev_rfp_dec = true;

            // Category 3: Engineering and Manufacturing Development Phase (EMD)
            attribute :>> phase_dev_contr = true;
            attribute :>> phase_sys_design = true;
            attribute :>> phase_develop_sys = true;
            attribute :>> phase_dev_testing = true;

            // Category 4: Production and Deployment Phase (P&D)
            attribute :>> phase_prod_contr = true;
            attribute :>> phase_lr_init_prod = true;
            attribute :>> phase_operational_test = true;
            attribute :>> phase_frp_dec = true;
            attribute :>> phase_fr = true;
            attribute :>> phase_prod_development = true;

            // Category 5: Operation and Support Phase (O&S)
            attribute :>> phase_sustainment_contr = true;
            attribute :>> phase_sustain_sys = true;

            // Category 6: All Phases
            attribute :>> phase_strategies = true;
            attribute :>> phase_tr = true;
            attribute :>> phase_cost_estimation_and_affordability = true;
            attribute :>> phase_program_management = true;
        }
    }
}
