
# Overview
The following solution design represents a custom implementation of the overall solution design for BasicCare/ODx.

The following inference process is implemented for BasicCare use case:
1. Clinical workspace pushes medical image(s) through gateway into HDP
2. Medical image information is collected by BasicCare backend service
3. Medical image is getting pre-processed in BasicCare backend service and pushed into BasicCare Azure Storage
4. BasicCare backend service invokes an event (CloudEvent) with AI backend
5. AI beckend starts orchestration ML workflow for inference event
6. Inference data to model matching is executed
7. Model discovery is executed
8. Model invocation is executed based on inference data to model matching
9. AI model application is retrieving pre-processed inference data from BasicCare storage
10. AI model application is executing inference on inference data
11. AI model application persists inference results in AI backend storage
12. AI model application is sending inference results notification through message broker
13. BasicCare service receives inference results notification through webhook
14. BasicCare service retrieves inference results from AI backend storage
15. BasicCare service and frontend visualize inference results 

![inference_solution_design_ODx_custom.svg](./.attachments/inference_solution_design_ODx_custom.svg)