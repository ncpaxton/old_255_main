from os import environ
from time import sleep

from github import Github
from github.GithubException import GithubException

admin_list = [
    "cbenge509",
    "siduojiang",
]
student_list = [
    # "cbenge509",
    # "sophiaski",
    # "AshwiniBhingare203",
    # "napoleon-paxton",
    # "siduojiang",
    # "mitch-karch",
    # "stemlock",
    # "dchacon-berkeley",
    # "johnslater3",
    # "mtblake",
    # "vasudev-killada-ucb",
    # "sudhrity",
    # "jdayer11",
    # "pmotameni",
    # "ivanwong-berkeley",
    # "Kklu78",
    # "danieljryu",
    # "eugene-shen ",
    # "sunitc-berk",
    # "lbrossi",
    # "spencer-weston",
    # "Jstilb",
    # "Stjokerli ",
    # "heatherpieszala",
    # "zcaksyu",
    # "grodriguez101",
    # "donaldziff",
    # "zcaksyu",
    # "grodriguez101",
    # "mukhivikram",
    # "kevinxuan",
    # "yaoc16",
    # "zwang-MIDS"
    # "tals1",
    # "Ngo-Kevin",
    # "orgoca"
]

def runner():
    g = Github(environ["GITHUB_PAT"])

    ORGANIZATION="UCB-W255"
    SEMESTER_REPO_PREFIX="spring22"
    org = g.get_organization(ORGANIZATION)
    # Get the default Student/Admin Team, can turn into a search on org.get_teams if needed later
    # Team(name="Students", id=5538453)
    # Team(name="Admin", id=5538478)
    student_team = org.get_team(5538453)
    admin_team = org.get_team(5538478)

    # Add Students to Org
    for student in student_list:
        print(f"Adding {student} to {ORGANIZATION} organization")
        user = g.get_user(student)
        try:
            org.invite_user(user)
        except GithubException as e:
            print(e)

    # Add Admin to the Admin Team
    # for admin in admin_list:
    #     print(f"Adding {admin} to admin team")
    #     user = g.get_user(admin)
    #     admin_team.add_membership(user)

    # Add Students to the Student Team
    for student in student_list:
        print(f"Adding {student} to Student team")
        user = g.get_user(student)
        student_team.add_membership(user)

    # Create Student Repo with student as admin
    for student in student_list:
        repo = f"{SEMESTER_REPO_PREFIX}-{student}"
        print(f"Creating {student} repo: {repo}")
        user = g.get_user(student)
        repo = org.create_repo(repo, private=True)
        sleep(5)
        repo.add_to_collaborators(user, permission="admin")

