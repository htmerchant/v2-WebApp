package DETECT_Input_Tool_Types {
    doc
    /* User Input File for UC2.
     * Instructions: Set the boolean value to 'true' if your DE ecosystem 
     * needs to support that specific lifecycle phase.
     */

    private import DETECT_Tool_Types::*; 

    part ecosystem_tool_profile : Tool_Profile { 
        
        item :>> inputs {
            // Category 1: Concept & Requirements
            attribute :>> phase_concept_exploration = true;
            attribute :>> phase_requirements_definition = true;

            // Category 2: Architecture & Design
            attribute :>> phase_system_architecture = true;
            attribute :>> phase_detailed_engineering = true;

            // Category 3: Software & Implementation
            attribute :>> phase_software_development = false;

            // Category 4: Integration, Test & Evaluation
            attribute :>> phase_system_integration = true;
            attribute :>> phase_test_and_evaluation = true;

            // Category 5: Manufacturing & Production
            attribute :>> phase_manufacturing_planning = false;

            // Category 6: Operations & Sustainment
            attribute :>> phase_operations_monitoring = false;
            attribute :>> phase_maintenance_and_sustainment = false;
        }
    }
}
