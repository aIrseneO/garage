#!/usr/bin/env python
""" Print all of the clone-urls for a GitHub organization.
It requires the pygithub3 module, which you can install like this::
    $ sudo apt -y install python3-virtualenv
    $ virtualenv my-virtualenv
    $ source my-virtualenv/bin/activate
    $ pip3 install -r requirements.txt
Usage example::
    $ python main.py
"""
import os
import json
from github import Github
from github import Auth

if "GITHUB_TOKEN" in os.environ:
    ACCESS_TOKEN = os.getenv("GITHUB_TOKEN")
else:
    raise Exception("GITHUB_TOKEN environment variable not set.")

def getReposPerOrgs() -> dict:
    try:
        auth = Auth.Token(ACCESS_TOKEN)
        githubObj = Github(auth = auth)
        user = githubObj.get_user()
        
        myRepos = {}
        for org in user.get_orgs():
            myRepos[org.login] = [repo.name for repo in org.get_repos()]
            # myRepos[org.login] = []
            # for repo in org.get_repos():
            #     myRepos[org.login].append(repo.name)

        myRepos[user.login] = [repo.name for repo in user.get_repos() 
                                if repo.full_name.startswith(user.login + "/")]
        # myRepos[user.login] = []
        # for repo in user.get_repos():
        #     if repo.full_name.startswith(user.login + "/"):
        #         myRepos[user.login].append(repo.name)
    except Exception as e:
        print("Error getting repos: {}".format(e))
    finally:
        if githubObj:
            githubObj.close()
    return myRepos


if __name__ == '__main__':
    print(json.dumps(getReposPerOrgs(), indent = 2))