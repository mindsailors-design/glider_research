Firstly, rename current origin to bitbucket (just in case so you can use it in the future):
```
❯ git remote rename origin bitbucket
```

Generate new ssh keys for new github account:
```
❯ ssh-keygen -t ed25519 -C "jacek.skarupa@mindsailors.com" -f id_ed25519_github_second
```

Add new entry in .ssh/config:
```
Host github-second
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519_github_second
```

Try to authenticate yourself to the github.com:
```
❯ ssh -T git@github-second
Hi mindsailors-design! You've successfully authenticated, but GitHub does not provide shell access.
```

Now you can add new remote repo url:
```
❯ git remote add origin git@github-second:mindsailors-design/backlight_server_client.git
```

In case of a booboo you can remove newly added origin:
```
❯ git remote remove origin
```

After adding new remote origin you should be able to push repo to github:
```
❯ git push -u origin --all
```
