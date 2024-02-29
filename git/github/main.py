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
from git import Repo
import logging

logging.basicConfig(level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s')

PWD = os.getcwd()

WORKDIR = f"{ os.path.expanduser('~')}/workdir"

def getGithubObj() -> Github:
    if "GITHUB_TOKEN" in os.environ:
        ACCESS_TOKEN = os.getenv("GITHUB_TOKEN")
    else:
        logging.error("'GITHUB_TOKEN' environment variable not set.")
        return None

    try:
        auth = Auth.Token(ACCESS_TOKEN)
        githubObj = Github(auth = auth)
    except Exception as e:
        logging.exception("Github auth fialed: {}".format(e))
        return None
    return githubObj

def getRepos(githubObj: Github) -> dict:
    orgsRepositories = {}
    if githubObj == None:
        return {}
    
    try:
        user = githubObj.get_user()
        for org in user.get_orgs():
            orgsRepositories[org.login] = [repo.name for repo in org.get_repos()]
            # orgsRepositories[org.login] = []
            # for repo in org.get_repos():
            #     orgsRepositories[org.login].append(repo.name)

        orgsRepositories[user.login] = [repo.name for repo in user.get_repos() 
                                if repo.full_name.startswith(user.login + "/")]
        # orgsRepositories[user.login] = []
        # for repo in user.get_repos():
        #     if repo.full_name.startswith(user.login + "/"):
        #         orgsRepositories[user.login].append(repo.name)
    except Exception as e:
        logging.exception("Error getting repos: {}".format(e))
    return orgsRepositories

def createWorkplace(
        orgsRepositories: dict = {},
        githubObj: Github = None,
        directory: str = PWD,
        orgsExcluded: list = []) -> int:
    try:
        for orgName, reposName in orgsRepositories.items():
            if orgName not in orgsExcluded:
                orgLocalDir = f"{ directory }/{ orgName }"
                os.makedirs(name = orgLocalDir, mode = 0o775, exist_ok = True)
                os.chmod(orgLocalDir, 0o775)
                if githubObj == None:
                    continue
                for repoName in reposName:
                    if (os.path.isdir(f"{ orgLocalDir }/{ repoName }")):
                        logging.info("Repository '{}/{}' exists already.".format(orgName, repoName))
                        continue
                    Repo.clone_from(
                        githubObj.get_repo(f"{ orgName }/{ repoName }").clone_url,
                        f"{ orgLocalDir }/{ repoName }"
                    )
                    logging.info("Repository '{}/{}' cloned.".format(orgName, repoName))
    except Exception as e:
        logging.exception("Error Creating workpalce: {}".format(e))
        return 1
    return 0

if __name__ == '__main__':

    githubObj = getGithubObj()

    orgsRepositories = getRepos(githubObj)
    # print(json.dumps(repos, indent = 2))

    createWorkplace(
        orgsRepositories = orgsRepositories,
        githubObj = githubObj,
        directory = WORKDIR,
        orgsExcluded = ["42-ready-player-hackathon"]
    )

    if githubObj != None:
        githubObj.close()