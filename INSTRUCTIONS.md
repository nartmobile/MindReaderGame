# Standard Git Workflow
Git workflow basics so work doesn't get mixed up and to practice git a bit more
<br/>

## Branching
1. Work off of a branch seperate from 'main'. Main should only have perfectly functional code  
`git checkout -b {branch name}`  
Name your branch after your name or feature you are implementing(doesn't matter)
<br/>

2. Pushing changes to remote repo
    * When remote branch doesn't exist yet  
`git push -u origin {branch name}`  
Pushes commited code and sets upstream at the same time  
    * When remote branch exists  
`git push origin {branch name}`  

## Pull request and pulling
1. When your branch has perfectly working code suitable for the main branch, submit pull request through github to be reviewed
2. Make sure your branch is up to date with main  
run `git pull origin main` to merge main's changes to your branch. (you'll solve merge conflicts)  
Makes it easier to review pull request and merge into main since your pull is up to date with main
