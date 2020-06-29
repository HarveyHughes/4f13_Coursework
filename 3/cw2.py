import matplotlib.pyplot as plt
import numpy as np


def sorted_barplot(mlm, word_ids,M):
    """
    Function for making a sorted bar plot based on values in P, and labelling the plot with the
    corresponding names
    :param P: An array of length num_players (107)
    :param W: Array containing names of each player
    :return: None
    """
    W = len(mlm)
    xx = np.linspace(0, M, M)
    plt.figure(figsize=(20, 20))
    sorted_indices = np.argsort(mlm)
    sorted_names = word_ids[sorted_indices]
    print(sorted_names)
    plt.barh(xx, mlm[sorted_indices[W - M - 1:-1]])
    plt.yticks(np.linspace(0, M, M), labels=sorted_names[W - M - 1:-1])
    plt.ylim([-2, 22])
    plt.xlabel('Word Probability')
    plt.ylabel('Word IDs')
    plt.show()
    plt.rc('axes', titlesize='xx-large')  # fontsize of the axes title
    plt.rc('axes', labelsize='xx-large')  # fontsize of the x and y labels
    plt.rc('xtick', labelsize='xx-large')  # fontsize of the tick labels
    plt.rc('ytick', labelsize='xx-large')  # fontsize of the tick labels
    plt.rc('legend', fontsize='xx-large')