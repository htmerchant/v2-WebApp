package DETECT_Tool_Types {
    doc
    /* Use Case 2 (UC2): Identify DE ecosystem Tool Types by Lifecycle Phase.
     * Defines the logic to map user-selected lifecycle phases to required tool categories.
     */

    import ScalarValues::Boolean;

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
            // Category 1: Concept & Requirements
            attribute phase_concept_exploration : Boolean default false;
            attribute phase_requirements_definition : Boolean default false;

            // Category 2: Architecture & Design
            attribute phase_system_architecture : Boolean default false;
            attribute phase_detailed_engineering : Boolean default false;

            // Category 3: Software & Implementation
            attribute phase_software_development : Boolean default false;

            // Category 4: Integration, Test & Evaluation
            attribute phase_system_integration : Boolean default false;
            attribute phase_test_and_evaluation : Boolean default false;

            // Category 5: Manufacturing & Production
            attribute phase_manufacturing_planning : Boolean default false;

            // Category 6: Operations & Sustainment
            attribute phase_operations_monitoring : Boolean default false;
            attribute phase_maintenance_and_sustainment : Boolean default false;
        }

        /**
         * MODEL OUTPUTS: Recommended Tools organized by Lifecycle Phase.
         * These derived attributes check the inputs and output sets of Tool_Type_e.
         */
        
        // --- Category 1 Outputs ---
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
