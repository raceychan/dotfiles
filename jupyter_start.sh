conda activate myproject
nohup /home/ubuntu/anaconda3/envs/myproject/bin/jupyter-lab --config=/home/ubuntu/.jupyter/jupyter_lab_config.py --port 8326 --allow-root > mylab.log --notebook-dir=/home/ubuntu &
