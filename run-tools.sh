#!/bin/bash
set -rv

for config in `ls configs/katello/*.yaml | sort -V | tail -n 3`
do
  config_number=`basename ${config} .yaml`
  echo $config_number
  ruby tools.rb setup-environment $config
  ruby tools.rb cherry-picks $config
  ruby tools.rb changelog $config
  for changelog in `ls repos/katello/**/katello/CHANGELOG.md`
  do
    version=`echo ${changelog} | cut -d "/" -f3`
    mv "${changelog}" "${PWD}/CHANGELOG_${version}.md"
  done
done
