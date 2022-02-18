## How to Use
Copy both the scripts to the champsim folder along with the sims file.
The sims file contains the list of simulators to be run one per line.
Run the auto.sh script with the sims file as an argument
`./auto.sh sims`
This should schedule all the sims as sbatch jobs on the server. The output of this script can be found in the logs folder in the home directory if it exists with the name auto_script_logs_\<pid\>.txt.
The output of each sbatch job can be found in <simulation_name>.txt in the champsim folder. Each job is given the name of the simulation.
