package DETECT_Input_Job_Series {
    doc
    /* User Input File for UC3.
     * Instructions: Set the boolean value to 'true' if your DE ecosystem 
     * needs to support that specific job series.
     */

    private import DETECT_Job_Series::*; 

    part job_series_tool_profile : Job_Series_Profile { 
        
        item :>> inputs {

            attribute :>> 'Category 1: Engineering and Architecture Group'.role_general_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_safety_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_materials_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_mechanical_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_nuclear_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_electrical_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_computer_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_aerospace_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_chemical_engineering = false;
            attribute :>> 'Category 1: Engineering and Architecture Group'.role_industrial_engineering = false;

            attribute :>> 'Category 2: Physical Siences Group'.role_physics = false;
            attribute :>> 'Category 2: Physical Siences Group'.role_chemistry = false;

            attribute :>> 'Category 3: Mathematical Sciences Group'.role_general_mathematics_and_statistics = false;
            attribute :>> 'Category 3: Mathematical Sciences Group'.role_operations_research = false;
            attribute :>> 'Category 3: Mathematical Sciences Group'.role_computer_science = false;
        }
    }
}
