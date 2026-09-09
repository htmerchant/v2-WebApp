package DETECT_Job_Series0 {
    doc
    /* Use Case 3 (UC3): Identify DE ecosystem Tool Types by Job Series.
     * Defines the logic to map user-selected job series to required tool categories.
     */

    private import ScalarValues::Boolean;

    /**
     * Enumeration of standard Digital Engineering tool categories.
     * This list is reused from UC2 for consistency.
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

    part def DETECT_user_jobs {
        doc
        /* A person using DETECT method to evaluate DE tool using UC2. */
    }

    use case def DETECT_uc3_Def {
        attribute uc_status defined by status_e_jobs default status_e_jobs::Red;
    }    

    /**
     * The Job_Series_Profile part defines the structure for capturing an organization's
     * roles and outputting the tool types they require.
     */
    part def Job_Series_Profile {
        
        /**
         * USER INPUTS: 3 Job Series Categories with Boolean selections for roles.
         */
        item inputs {
            // Category 1: Engineering and Architecture Group
            attribute role_general_engineering : Boolean default false;
            attribute role_safety_engineering : Boolean default false;
            attribute role_materials_engineering : Boolean default false;
            attribute role_mechanical_engineering : Boolean default false;
            attribute role_nuclear_engineering : Boolean default false;
            attribute role_electrical_engineering : Boolean default false;
            attribute role_computer_engineering : Boolean default false;
            attribute role_aerospace_engineering : Boolean default false;
            attribute role_chemical_engineering : Boolean default false;
            attribute role_industrial_engineering : Boolean default false;

            // Category 2: Physical Siences Group
            attribute role_physics : Boolean default false;
            attribute role_chemistry : Boolean default false;

            // Category 3: Mathematical Sciences Group
            attribute role_general_mathematics_and_statistics : Boolean default false;
            attribute role_operations_research : Boolean default false;
            attribute role_computer_science : Boolean default false;
        }

        /* --- MODEL OUTPUTS --- */

        /* --- 1 - Engineering and Architecture Group --- */

        derived attribute general_engineering_tools : Tool_Type_e[*] =
            if inputs.role_general_engineering ?
            (
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
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

        derived attribute safety_engineering_tools : Tool_Type_e[*] =
            if inputs.role_safety_engineering ?
            (
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'7.4 Sustainment and Maintenance',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;
            
        derived attribute materials_engineering_tools : Tool_Type_e[*] =
            if inputs.role_materials_engineering ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute mechanical_engineering_tools : Tool_Type_e[*] =
            if inputs.role_mechanical_engineering ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.1 Physical Product Definition and Representation',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute nuclear_engineering_tools : Tool_Type_e[*] =
            if inputs.role_nuclear_engineering ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute electrical_engineering_tools : Tool_Type_e[*] =
            if inputs.role_electrical_engineering ?
            (
                Tool_Type_e::'1.2 Electrical computer-aided design (ECAD)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'6.3 Manufacturing Execution Software (MES)',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute computer_engineering_tools : Tool_Type_e[*] =
            if inputs.role_computer_engineering ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'3.1 Requirements Management Tools',
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

        derived attribute aerospace_engineering_tools : Tool_Type_e[*] =
            if inputs.role_aerospace_engineering ?
            (
                Tool_Type_e::'1.1 Computer Aided Design (CAD)',
                Tool_Type_e::'1.3 Product Lifecycle Management (PLM)',
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute chemical_engineering_tools : Tool_Type_e[*] =
            if inputs.role_chemical_engineering ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute industrial_engineering_tools : Tool_Type_e[*] =
            if inputs.role_industrial_engineering ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'3.1 Requirements Management Tools',
                Tool_Type_e::'3.2 Architecture Tools',
                Tool_Type_e::'3.3 Shared Architecture Tools',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
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
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        /* --- 2 - Physical Sciences Group --- */

        derived attribute physics_tools : Tool_Type_e[*] =
            if inputs.role_physics ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.2 Computational Fluid Dynamics (CFD)',
                Tool_Type_e::'2.3 Finite Element Analysis (FEA)',
                Tool_Type_e::'2.4 Electromagnetic (EM)',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'4.1 Integrated Development Environments (IDEs)',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute chemistry_tools : Tool_Type_e[*] =
            if inputs.role_chemistry ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;
            
        /* --- 3 - Mathematical Sciences Group --- */

        derived attribute general_math_and_stats_tools : Tool_Type_e[*] =
            if inputs.role_general_mathematics_and_statistics ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'4.1 Integrated Development Environments (IDEs)',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.2 Data Integration',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute ops_research_tools : Tool_Type_e[*] =
            if inputs.role_operations_research ?
            (
                Tool_Type_e::'2.1 Low Fidelity Simulations',
                Tool_Type_e::'2.5 Dynamic Simulations',
                Tool_Type_e::'2.6 Mission Models',
                Tool_Type_e::'2.7 Simulation Managers',
                Tool_Type_e::'4.1 Integrated Development Environments (IDEs)',
                Tool_Type_e::'4.2 Version Control Systems',
                Tool_Type_e::'5.1 Data Analytics and Visualization',
                Tool_Type_e::'5.4 Digital Thread',
                Tool_Type_e::'7.1 Supply Chain Planning & Optimization',
                Tool_Type_e::'7.2 Transportation and Distribution Management',
                Tool_Type_e::'7.4 Sustainment and Maintenance',
                Tool_Type_e::'8.1 Word Processing and Document Collaboration',
                Tool_Type_e::'8.2 Presentation Software',
                Tool_Type_e::'8.3 Spreadsheets',
                Tool_Type_e::'8.4 Email and Communication Platforms',
                Tool_Type_e::'8.5 Task Management and Project Planning',
                Tool_Type_e::'8.6 Shared Drives and Cloud Storage'
            )
            else null;

        derived attribute compsci_tools : Tool_Type_e[*] =
            if inputs.role_computer_science ?
            (
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
    }

    enum def status_e_jobs {
        Green {
            doc
            /* The feature is implemented */
        }
        Red {
            doc
            /* The feature is NOT implemented */
        }
    }

}
