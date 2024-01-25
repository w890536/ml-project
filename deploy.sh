"deploy": "gh-pages -d dist"
9️⃣ Save all the changes you've made.
🔟 Inside your project, create a new file, deploy.sh, with the following content.
You can find this in the Vite documentation [here](https://v3.vitejs.dev/guide/static-deploy.html#github-pages). Uncomment according to your chosen option.
#!/usr/bin/env sh
# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

# place .nojekyll to bypass Jekyll processing
echo > .nojekyll

# if you are deploying to a custom domain
# echo 'www.example.com' > CNAME

git init
git checkout -B main
git add -A
git commit -m 'deploy'

# if you are deploying to https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git main

# if you are deploying to https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git main:gh-pages

cd -
