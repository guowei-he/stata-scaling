#!/bin/bash
#SBATCH -p serial
# Set number of tasks to run
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=NTHREADS
# Walltime format hh:mm:ss
#SBATCH --time=01:30:00
#SBATCH -C CONSTRAINT
# Output and error files
#SBATCH -o job-%A-%a.out
#SBATCH -a 1-MAXTRAIL
#SBATCH -J NTHREADS-stata.out

# **** Put all #SBATCH directives above this line! ****
# **** Otherwise they will not be in effective! ****
#
# **** Actual commands start here ****
# Load modules here (safety measure)
module purge

nthreads=NTHREADS
trail=${SLURM_ARRAY_TASK_ID}
run_dir="run_threads_${nthreads}_${trail}"
cd $run_dir
job_script="stata-job.sh"
bash ${job_script}
