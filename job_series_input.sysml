package DETECT_Input_Job_Series {
    doc
    /* User Input File for UC3.
     * Instructions: Set the boolean value to 'true' if your DE ecosystem 
     * needs to support that specific job series.
     */

    private import DETECT_Job_Series::*; 

    part job_series_tool_profile : Job_Series_Profile { 
        
        item :>> inputs {
            // Category 1: Engineering & Scientific
            attribute :>> role_general_engineering = false;
            attribute :>> role_safety_engineering = false;
            attribute :>> role_materials_engineering = false;
            attribute :>> role_mechanical_engineering = false;
            attribute :>> role_nuclear_engineering = false;
            attribute :>> role_electrical_engineering = false;
            attribute :>> role_computer_engineering = false;
            attribute :>> role_aerospace_engineering = false;
            attribute :>> role_chemical_engineering = false;
            attribute :>> role_industrial_engineering = false;

            // Category 2: Program & Business Management
            attribute :>> role_physics = false;
            attribute :>> role_chemistry = false;

            // Category 3: Support & Operations
            attribute :>> role_general_mathematics_and_statistics = false;
            attribute :>> role_operations_research = false;
            attribute :>> role_computer_science = false;
        }
    }
}
