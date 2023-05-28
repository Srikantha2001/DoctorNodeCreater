import pandas as pd
import shlex
import subprocess



df = pd.read_csv('variable.csv')

# Creating a dictionary to get all environment variable values
env_dict={}
for index in range(len(df.index)):
    env_dict[df['KeyColumn'].iloc[index]] =df['DataColumn'].iloc[index]


env_dict['peer_number']=0
env_dict['peer_port']=10000
env_dict['listen_port']=9444
env_dict['couchdb_port']=15000

modified_dict = {'KeyColumn':list(env_dict.keys()),'DataColumn':list(env_dict.values())}
new_df = pd.DataFrame(modified_dict)

# Storing back to same csv file
new_df.to_csv('variable.csv')


subprocess.run(shlex.split('./network.sh down'))