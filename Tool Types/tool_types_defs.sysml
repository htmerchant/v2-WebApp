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
        '1 Physical System Representation';
        '1.1 Computer Aided Design (CAD)';
        '1.2 Electrical computer-aided design (ECAD)';
        '1.3 Product Lifecycle Management (PLM)';
        '2 Simulations';
        '2.1 Low Fidelity Simulations';
        '2.2 Computational Fluid Dynamics (CFD)';
        '2.3 Finite Element Analysis (FEA)';
        '2.4 Electromagnetic (EM)';
        '2.5 Dynamic Simulations';
        '2.6 Mission Models';
        '2.7 Simulation Managers';
        '3 Model Based System-Engineering (MBSE) and System Architecture and Design Tools';
        '3.1 Requirements Management Tools';
        '3.2 Architecture Tools';
        '3.3 Shared Architecture Tools';
        '4 Computer Science and Software Engineering Tools';
        '4.1 Integrated Development Environments (IDEs)';
        '4.2 Version Control Systems';
        '4.3 Continuous Integration/Continuous Deployment (CI/CD):';
        '4.4 Testing Frameworks';
        '5 Data Integration';
        '5.1 Data Analytics and Visualization';
        '5.2 Data Integration';
        '5.3 Data Persistence';
        '5.4 Digital Thread';
        '6 Manufacturing';
        '6.1 Physical Product Definition and Representation';
        '6.2 Process Modeling & Simulation';
        '6.3 Manufacturing Execution Software (MES)';
        '7 Logistics';
        '7.1 Supply Chain Planning & Optimization';
        '7.2 Transportation and Distribution Management';
        '7.3 Inventory Management';
        '7.4 Sustainment and Maintenance';
        '8 Productivity Tools in Digital Engineering';
        '8.1 Word Processing and Document Collaboration';
        '8.2 Presentation Software';
        '8.3 Spreadsheets';
        '8.4 Email and Communication Platforms';
        '8.5 Task Management and Project Planning';
        '8.6 Shared Drives and Cloud Storage';
        '9 Host Platform';
        '10 Cybersecurity';
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
            attribute phase_sustain_sys : Boolean default false;

            // Category 6: All Phases
            attribute phase_strategies : Boolean default false;
            attribute phase_tr : Boolean default false;
            attribute phase_cost_estimation_and_affordability : Boolean default false;
            attribute phase_program_management : Boolean default false;
        }

        /**
         * MODEL OUTPUTS: Recommended Tools organized by Lifecycle Phase.
         * These derived attributes check the inputs and output sets of Tool_Type_e.
         * if user inputs A, then return the tool type corresponding to A (I think)
         */
        
        /* ---  Category 1 Outputs --- */
        derived attribute :>> concept_phase_tools : {Tool_Type_e[*]} =
            if inputs.phase_concept_exploration then {Tool_Type_e::'1 Physical System Representation'} else {};
            
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
