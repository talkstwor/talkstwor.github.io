jekyll build  --destination _deploy
touch _deploy/CNAME
echo 'conferences.tworitdash.in' > _deploy/CNAME
cd _deploy
 
git add .
git commit -m "Static"

git push -u origin master 
cd ..

git add .
git commit -m "Source Added"
git push origin source
