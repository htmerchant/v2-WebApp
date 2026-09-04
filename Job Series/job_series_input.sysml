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
            attribute :>> role_general_engineering = true;
            attribute :>> role_safety_engineering = true;
            attribute :>> role_materials_engineering = true;
            attribute :>> role_mechanical_engineering = true;
            attribute :>> role_nuclear_engineering = true;
            attribute :>> role_electrical_engineering = true;
            attribute :>> role_computer_engineering = true;
            attribute :>> role_aerospace_engineering = true;
            attribute :>> role_chemical_engineering = true;
            attribute :>> role_industrial_engineering = true;

            // Category 2: Program & Business Management
            attribute :>> role_physics = true;
            attribute :>> role_chemistry = true;

            // Category 3: Support & Operations
            attribute :>> role_general_mathematics_and_statistics = true;
            attribute :>> role_operations_research = true;
            attribute :>> role_computer_science = true;
        }
    }
}
