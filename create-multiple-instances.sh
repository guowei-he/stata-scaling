#!/bin/bash

MAXTRAIL=1
CONSTRAINT=sse
RUNDIR="run"
TEMPLATEDIR="${PWD}/template"

if [[ ! -d "${RUNDIR}" ]]; then
  mkdir ${RUNDIR}
fi
cd ${RUNDIR}

for nthreads in 1 2 4 8 12 ; do
  rm -fr $nthreads
  mkdir $nthreads
  cd $nthreads
  ja_script="submit-ja.sh"
  cp ${TEMPLATEDIR}/${ja_script} ./
  sed "s/MAXTRAIL/$MAXTRAIL/" -i ${ja_script}
  sed "s/CONSTRAINT/$CONSTRAINT/" -i ${ja_script}
  sed "s/NTHREADS/$nthreads/" -i ${ja_script}
  for trail in `seq 1 ${MAXTRAIL}` ; do
    run_dir="run_threads_${nthreads}_${trail}"
    rm -fr $run_dir
    mkdir $run_dir
    job_script="stata-job.sh"
    do_script="test.do"
    cd $run_dir
    cp ${TEMPLATEDIR}/$job_script ./
    cp ${TEMPLATEDIR}/$do_script ./
    sed "s/NTHREADS/$nthreads/" -i $job_script
    sed "s/NTHREADS/$nthreads/" -i $do_script
    sed "s/TRAIL/$trail/" -i $job_script
    cd ..
  done
  sbatch ${ja_script}
  cd ..
done
