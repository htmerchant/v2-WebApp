package DETECT_Tool_Types {
    doc
    /* Use Case 2 (UC2): Identify DE ecosystem Tool Types by Lifecycle Phase.
     * Defines the logic to map user-selected lifecycle phases to required tool categories.
     */

    private import ScalarValues::Boolean;

    /**
     * Enumeration of standard Digital Engineering tool categories.
     */
    enum def Tool_Type_e {
        'Requirements Management (RM)';
        'Model-Based Systems Engineering (MBSE)';
        'Product Lifecycle Management (PLM)';
        'Mechanical CAD (MCAD)';
        'Electrical CAD (ECAD)';
        'Computer-Aided Engineering (CAE) / Simulation';
        'Software Integrated Development Environment (IDE)';
        'Application Lifecycle Management (ALM)';
        'Test & Defect Management';
        'Manufacturing Execution System (MES)';
        'Digital Twin / IoT Monitoring';
        'Tech Data Package (TDP) Publishing';
    }

    /**
     * The Tool_Profile part defines the structure for capturing a user's
     * lifecycle phase needs and outputting the mapped tools.
     */
    part def Tool_Profile {
        
        /**
         * USER INPUTS: 6 Lifecycle Categories with Boolean selections for phases.
         */
        item inputs {
            // Category 1: Materiel Solutions Analysis Phase (MSA)
            attribute phase_development_requirements : Boolean default false;
            attribute phase_analysis_of_alternatives : Boolean default false;
            attribute phase_study_contracts : Boolean default false;

            // Category 2: Technology Maturity and Risk Reduction Phase (TMRR)
            attribute phase_mature_rqts : Boolean default false;
            attribute phase_proto_contr : Boolean default false;
            attribute phase_prototyping : Boolean default false;
            attribute phase_dev_prel_design : Boolean default false;
            attribute phase_cdd_validation : Boolean default false;
            attribute phase_dev_rfp_dec : Boolean default false;
            

            // Category 3: Engineering and Manufacturing Development Phase (EMD)
            attribute phase_dev_contr : Boolean default false;
            attribute phase_sys_design : Boolean default false;
            attribute phase_develop_sys : Boolean default false;
            attribute phase_dev_testing : Boolean default false;

            // Category 4: Production and Deployment Phase (P&D)
            attribute phase_prod_contr : Boolean default false;
            attribute phase_lr_init_prod : Boolean default false;
            attribute phase_operational_test : Boolean default false;
            attribute phase_frp_dec : Boolean default false;
            attribute phase_fr : Boolean default false;
            attribute phase_prod_development : Boolean default false;

            // Category 5: Operation and Support Phase (O&S)
            attribute phase_sustainment_contr : Boolean default false;
            attribute phase_sustain sys : Boolean default false;

            // Category 6: All Phases
            attribute phase_strategies : Boolean default false;
            attribute phase_tr : Boolean default false;
            attribute phase_cost_estimation_and_affordability : Boolean default false;
            attribute phase_program_management : Boolean default false;
        }

        /**
         * MODEL OUTPUTS: Recommended Tools organized by Lifecycle Phase.
         * These derived attributes check the inputs and output sets of Tool_Type_e.
         */
        
        // ---  Category 1 Outputs ---
        derived attribute :>> concept_phase_tools : {Tool_Type_e[*]} =
            if inputs.phase_concept_exploration then {Tool_Type_e::'MBSE'} else {};
            
        derived attribute :>> requirements_phase_tools : {Tool_Type_e[*]} =
            if inputs.phase_requirements_definition then {Tool_Type_e::'Requirements Management (RM)', Tool_Type_e::'MBSE'} else {};

        // --- Category 2 Outputs ---
        derived attribute :>> architecture_phase_tools : {Tool_Type_e[*]} =
            if inputs.phase_system_architecture then {Tool_Type_e::'MBSE', Tool_Type_e::'PLM'} else {};
            
        derived attribute :>> detailed_engineering_tools : {Tool_Type_e[*]} =
            if inputs.phase_detailed_engineering then {Tool_Type_e::'Mechanical CAD (MCAD)', Tool_Type_e::'Electrical CAD (ECAD)', Tool_Type_e::'Computer-Aided Engineering (CAE) / Simulation', Tool_Type_e::'PLM'} else {};

        // --- Category 3 Outputs ---
        derived attribute :>> software_development_tools : {Tool_Type_e[*]} =
            if inputs.phase_software_development then {Tool_Type_e::'Software Integrated Development Environment (IDE)', Tool_Type_e::'Application Lifecycle Management (ALM)'} else {};

        // --- Category 4 Outputs ---
        derived attribute :>> integration_and_test_tools : {Tool_Type_e[*]} =
            if inputs.phase_system_integration or inputs.phase_test_and_evaluation then {Tool_Type_e::'Test & Defect Management', Tool_Type_e::'Application Lifecycle Management (ALM)'} else {};

        // --- Category 5 Outputs ---
        derived attribute :>> manufacturing_tools : {Tool_Type_e[*]} =
            if inputs.phase_manufacturing_planning then {Tool_Type_e::'Manufacturing Execution System (MES)', Tool_Type_e::'PLM'} else {};

        // --- Category 6 Outputs ---
        derived attribute :>> ops_and_sustainment_tools : {Tool_Type_e[*]} =
            if inputs.phase_operations_monitoring then {Tool_Type_e::'Digital Twin / IoT Monitoring'} else {} +
            if inputs.phase_maintenance_and_sustainment then {Tool_Type_e::'Tech Data Package (TDP) Publishing', Tool_Type_e::'PLM'} else {};
    }
}
