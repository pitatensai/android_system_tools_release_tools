#!/bin/bash
#if [[ $REPO_REMOTE == rk* ]] || [[ $REPO_RREV == rk33* ]]; then
if test -d $PATCHES_PATH/$REPO_PATH
then
    GIT_HEAD=`grep commit $PATCHES_PATH/$REPO_PATH/git-merge-base.txt |cut -c8-47`
    HAVE_PATCH=`find $PATCHES_PATH/$REPO_PATH -name *.patch`
    HAVE_DIFF=`find $PATCHES_PATH/$REPO_PATH -name *.diff`
    git stash && git checkout -b restore_$DATE $GIT_HEAD
    #git branch -D restore_temp01
    if [ -n "$HAVE_PATCH" ]; then
        git am $PATCHES_PATH/$REPO_PATH/*.patch
        #echo $HAVE_PATCH
    fi

    if [ -n "$HAVE_DIFF" ]; then
        git apply $PATCHES_PATH/$REPO_PATH/local_diff.diff
        #echo $HAVE_DIFF
    fi

    if [ -n "$HAVE_PATCH" -o -n "$HAVE_DIFF" ]; then
        echo Restore patch for "$REPO_PATH" done
    fi
fi
#fi
