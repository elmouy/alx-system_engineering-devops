#!/usr/bin/python3
"""Script that returns the numbers of
subscribers of a subreddit passed to it"""

import requests


def number_of_subscribers(subreddit):
    """Function that returns the numbers of
    subscribers of a subreddit passed to it"""

    apiUrl = "https://reddit.com/r/{}/about.json".format(subreddit)
    userAgent = "Google Chrome/120.0.6099.217"

    response = requests.get(apiUrl, headers={"user-agent": userAgent})
    if not response:
        return 0
    retValue = response.json().get('data').get('subscribers')
    if retValue:
        return retValue
    else:
        return 0
