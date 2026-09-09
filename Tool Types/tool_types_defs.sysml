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
        '4.3 Continuous Integration/Continuous Deployment (CI/CD)';
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
            attribute phase_develop_requirements : Boolean default false;
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
            attribute phase_prod_deployment : Boolean default false;

            // Category 5: Operation and Support Phase (O&S)
            attribute phase_sustainment_contr : Boolean default false;
            attribute phase_sustain_sys : Boolean default false;

            // Category 6: All Phases
            attribute phase_strategies : Boolean default false;
            attribute phase_tr : Boolean default false;
            attribute phase_cost_estimation_and_affordability : Boolean default false;
            attribute phase_program_management : Boolean default false;
        }

        /* --- MODEL OUTPUTS --- */

        /* --- 1 MSA - Materiel Solutions Analysis Phase --- */

        derived attribute develop_requirements_tools : Tool_Type_e[*] =
            if inputs.phase_develop_requirements ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute analysis_of_alternatives_tools : Tool_Type_e[*] =
            if inputs.phase_analysis_of_alternatives ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',                
                Tool_Type_e::'3.3 Shared Architecture Tools',      
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute study_contracts_tools : Tool_Type_e[*] =
            if inputs.phase_study_contracts ?
            (
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        /* --- 2 TMRR - Technology Maturity and Risk Reduction Phase --- */

        derived attribute mature_rqts_tools : Tool_Type_e[*] =
            if inputs.phase_mature_rqts ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools', 
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute proto_contr_tools : Tool_Type_e[*] =
            if inputs.phase_proto_contr ?
            (
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute prototyping_tools : Tool_Type_e[*] =
            if inputs.phase_prototyping ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'1.2 Electrical computer-aided design (ECAD)',
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute dev_prel_design_tools : Tool_Type_e[*] =
            if inputs.phase_dev_prel_design ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'1.2 Electrical computer-aided design (ECAD)',
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute cdd_validation_tools : Tool_Type_e[*] =
            if inputs.phase_cdd_validation ?
            (
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute dev_rfp_dec_tools : Tool_Type_e[*] =
            if inputs.phase_dev_rfp_dec ?
            (
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        /* --- 3 EMD - Engineering and Manufacturing Development Phase --- */

        derived attribute dev_contr_tools : Tool_Type_e[*] =
            if inputs.phase_dev_contr ?
            (
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute sys_design_tools : Tool_Type_e[*] =
            if inputs.phase_sys_design ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'1.2 Electrical computer-aided design (ECAD)',
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'4.1 Integrated Development Environments (IDEs)',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'4.3 Continuous Integration/Continuous Deployment (CI/CD)',
                Tool_Type_e::'4.4 Testing Frameworks',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute develop_sys_tools : Tool_Type_e[*] =
            if inputs.phase_develop_sys ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'1.2 Electrical computer-aided design (ECAD)',
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'4.1 Integrated Development Environments (IDEs)',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'4.3 Continuous Integration/Continuous Deployment (CI/CD)',
                Tool_Type_e::'4.4 Testing Frameworks',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute dev_testing_tools : Tool_Type_e[*] =
            if inputs.phase_dev_testing ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'4.1 Integrated Development Environments (IDEs)',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'4.3 Continuous Integration/Continuous Deployment (CI/CD)',
                Tool_Type_e::'4.4 Testing Frameworks',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;
        
        /* --- 4 P&D - Production and Deployment Phase --- */

        derived attribute prod_contr_tools : Tool_Type_e[*] =
            if inputs.phase_prod_contr ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute lr_init_prod_tools : Tool_Type_e[*] =
            if inputs.phase_lr_init_prod ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'7.2 Transportation and Distribution Management',
                Tool_Type_e::'7.3 Inventory Management',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute operational_test_tools : Tool_Type_e[*] =
            if inputs.phase_operational_test ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute frp_dec_tools : Tool_Type_e[*] =
            if inputs.phase_frp_dec ?
            (
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute fr_tools : Tool_Type_e[*] =
            if inputs.phase_fr ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'7.2 Transportation and Distribution Management',
                Tool_Type_e::'7.3 Inventory Management',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute prod_deployment_tools : Tool_Type_e[*] =
            if inputs.phase_prod_deployment ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.2 Process Modeling & Simulation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'7.2 Transportation and Distribution Management',
                Tool_Type_e::'7.3 Inventory Management',
                Tool_Type_e::'7.4 Sustainment and Maintenance',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;  

        /* --- 5 O&S - Operations and Support Phase --- */

        derived attribute sustainment_contr_tools : Tool_Type_e[*] =
            if inputs.phase_sustainment_contr ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        derived attribute sustain_sys_tools : Tool_Type_e[*] =
            if inputs.phase_sustain_sys ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.3 Data Persistence',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'7.2 Transportation and Distribution Management',
                Tool_Type_e::'7.3 Inventory Management',
                Tool_Type_e::'7.4 Sustainment and Maintenance',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage',
                Tool_Type_e::'9 Host Platform',
                Tool_Type_e::'10 Cybersecurity'
            )
            else null;

        /* --- 6 All Phases --- */

        derived attribute strategies_tools : Tool_Type_e[*] =
            if inputs.phase_strategies ?
            (
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute tr_tools : Tool_Type_e[*] =
            if inputs.phase_tr ?
            (
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute cost_estimation_and_affordability_tools : Tool_Type_e[*] =
            if inputs.phase_cost_estimation_and_affordability ?
            (
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute program_management_tools : Tool_Type_e[*] =
            if inputs.phase_program_management ?
            (
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;
    }
    
}
