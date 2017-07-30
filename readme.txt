#notes
if committing on windows from guest OS clear symlinks:
find . -type l | sed -e s'/^\.\///g' >> .gitignore
