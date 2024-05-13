import numpy as np

def filter_syn_df(syn_df, syn_thresh):
    
    indices_to_include = []

    # Find unique presynaptic neurons
    unique_pre_ids = syn_df.pre_pt_root_id.unique().tolist()

    # Loop through presynaptic neurons
    for i in unique_pre_ids:       
        pre_df = syn_df[syn_df.pre_pt_root_id == i]
        # Find unique postsynaptic neurons targeted by i-th presynaptic neuron
        unique_post_ids = pre_df.post_pt_root_id.unique().tolist() 
        # Loop through postsynaptic neurons
        for j in unique_post_ids:    
            # Is number of synapses onto j-th postsynaptic neuron larger than or equal to syn_thresh? 
            if sum(pre_df.post_pt_root_id == j) >= syn_thresh: 
                # Get indices (rows)
                indices = pre_df.index.values[pre_df.post_pt_root_id == j]       
                # Loop through indices 
                for k in indices:
                    # Append each index separately to avoid lists within list
                    indices_to_include.append(k)

    # Sort indices in ascending order
    indices_to_include.sort()
    
    # Create filtered syn_df 
    syn_df_filt = syn_df.loc[indices_to_include]
    
    return syn_df_filt


def convert_to_nm(col, voxel_size=[4.3,4.3,45]):
    return np.vstack(col.values)*voxel_size


def hl_nt_dict():
    
    hl_nt_dict = {
        '0A': 'GABA',
        '0A/0B': 'GABA',
        '1A': 'ACh',
        '1B': 'GABA',
        '2A': 'Glu',
        '3A': 'ACh',
        '3B': 'GABA',
        '4B': 'ACh',
        '5B': 'GABA',
        '6A': 'GABA',
        '6B': 'GABA',
        '7B': 'ACh',
        '8A': 'Glu',
        '8B': 'ACh',
        '9A': 'GABA',
        '9B': 'Glu',
        '10B': 'ACh',
        '11A': 'ACh',
        '11B': 'GABA',
        '12A': 'ACh',
        '12B': 'GABA',
        '13A': 'GABA',
        '13B': 'GABA',
        '14A': 'Glu',
        '15B': 'Glu',
        '16B': 'Glu',
        '17A': 'ACh',
        '18B': 'ACh',
        '19A': 'GABA',
        '19B': 'ACh',
        '20A': 'ACh',
        '21A': 'Glu', 
        '22A': 'ACh',
        '23B': 'ACh',
        '24B': 'Glu'}
    
    return hl_nt_dict


def compute_connectivity_matrix(syn_df):

    pre_ids = list(syn_df.pre_pt_root_id.unique())
    post_ids = list(syn_df.post_pt_root_id.unique())
    n_pre_ids = len(pre_ids)
    n_post_ids = len(post_ids)
    conn_mat = np.zeros([n_pre_ids,n_post_ids])
    for ix, i in enumerate(pre_ids):
        post_ids_temp = list(syn_df.post_pt_root_id[syn_df.pre_pt_root_id==i].unique())
        for jx, j in enumerate(post_ids):
            if j in post_ids_temp:
                conn_mat[ix,jx] = len(syn_df[(syn_df.pre_pt_root_id==i) & (syn_df.post_pt_root_id==j)])
    
    return conn_mat, pre_ids, post_ids


def sort_partial_match(input_list, list_sorter):
    # Construct a dictionary mapping to be able to sort partial matches 
    sort_map = {name: next((idx for idx, val in enumerate(list_sorter) if name.startswith(val)),
                 len(input_list)) for name in input_list}

    sorted_list = sorted(input_list, key=sort_map.__getitem__)
    
    return sorted_list    