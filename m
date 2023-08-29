Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4851C71153
	for <audit@archiver.kernel.org>; Tue, 29 Aug 2023 20:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbjH2UlN (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 29 Aug 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbjH2Ukr (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 29 Aug 2023 16:40:47 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953CCE6
        for <audit@vger.kernel.org>; Tue, 29 Aug 2023 13:40:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5925e580f12so55882037b3.3
        for <audit@vger.kernel.org>; Tue, 29 Aug 2023 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693341630; x=1693946430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hlfedfVtinUbqmdYFBe/AzCba8CTUSoEdjLTs8STP20=;
        b=ZZ6a1P+yZcDP7Qf+IzGsOHg/7YrtUAd/EbQBS4xGX9jBg/Ne/8xPgU9yPY0L+8ZPfa
         plCUh9US41vKc6njuz6QPbuSrMu+lyU7Fh68m2RqHWSIoPbLHMbA1isXeHavCSUlYieY
         SjpmZDPNJoRbwKkiekdyYIOuaU1TqNxfmgaeitxGdX2B/3mZxVMXaA4mPRC0TDiAubKW
         2t2h83lh8KytBjkVbMmfRhVR1pbVV+7FKNbLsMdUnqa/fYK9+zM5iYls2fXadzN6AfQC
         1XA30o2YUs6KFvdZhh6Ecai4uKuGdowufmeXiVzG8QhcmRHFJo3mE39vEOYu64j1xCzI
         mx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341630; x=1693946430;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlfedfVtinUbqmdYFBe/AzCba8CTUSoEdjLTs8STP20=;
        b=Ok3UamIwIWIFVQO1lZux42i4hYZEq5lVHKZLYaAzJD9ehx/TkzGwfzTmrBVp8wC7Or
         Mml/pfSlpLYS5wH1S6fv3fIKso72KIEOPruWQrV/FNnfxytJWvxfZcgTP08MozDhsNjs
         PVFARkRoEgV9Uwy0qJgzMVYGoz7WLGGrQ3NtKXNq8lKHlgGe0RLbjSbxEong/wDaQbFQ
         +Hp12oLW3I6ZX2QIz+t2QgyN+2I4huPbGeUl7SkJp1eF3YRyC+PbkUUY2YiqIHNHY2Ot
         QprA3NkEo5vUf1NLnZxqRqUKCpzrpcGGG+mg9v/7TUZyXBzWQd069Jbrg7pp3xEdBaj6
         KHYw==
X-Gm-Message-State: AOJu0YzSMmcf3XuhCrAVto2YwEw7uBmdvLFBbeq5FesQkZ67ZSXlBI/j
        uzeXz1Due0lt7A6p0wxzHkUMICpLDj5qBVTbIP43
X-Google-Smtp-Source: AGHT+IFXOpuwCFSd2fhY4qmIlbq10CMpPWUfjIWT4OURSYOScypZCmvsa5GLk1YS6iVQlmutjZ/IjVYiibQAmnsCwpU=
X-Received: by 2002:a0d:e8c1:0:b0:593:30b4:5d39 with SMTP id
 r184-20020a0de8c1000000b0059330b45d39mr140782ywe.18.1693341630138; Tue, 29
 Aug 2023 13:40:30 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Aug 2023 16:40:19 -0400
Message-ID: <CAHC9VhRBq5jsaDDs5bFy6HR88DQgbu7agjZOBvZfR17LY2GS8A@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hi Linus,

Six audit patches for the Linux v6.6 merge window, the highlights are
listed below:

- Add an explicit cond_resched() call when generating PATH records

Certain tracefs/debugfs operations can generate a *lot* of audit PATH
entries and if one has an aggressive system configuration (not the
default) this can cause a soft lockup in the audit code as it works to
process all of these new entries.  This is in sharp contrast to the
common case where only one or two PATH entries are logged.  In order
to fix this corner case without excessively impacting the common case
we're adding a single cond_rescued() call between two of the most
intensive loops in the __audit_inode_child() function.

- Various minor cleanups

We removed a conditional header file as the included header already
had the necessary logic in place, fixed a dummy function's return
value, and the usual collection of checkpatch.pl noise (whitespace,
brace, and trailing statement tweaks).

Please merge,
-Paul

--
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

 Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20230829

for you to fetch changes up to b1a0f64cc65ea2ebfaae9e0ce623e993a7d24257:

 audit: move trailing statements to next line (2023-08-15 18:16:14 -0400)

----------------------------------------------------------------
audit/stable-6.6 PR 20230829

----------------------------------------------------------------
Atul Kumar Pant (3):
     audit: add space before parenthesis and around '=', "==", and '<'
     audit: cleanup function braces and assignment-in-if-condition
     audit: move trailing statements to next line

Gaosheng Cui (1):
     audit: fix possible soft lockup in __audit_inode_child()

Xiu Jianfeng (2):
     audit: include security.h unconditionally
     audit: correct audit_filter_inodes() definition

kernel/acct.c        |  2 +-
kernel/audit.c       |  5 ++---
kernel/audit.h       |  2 +-
kernel/auditfilter.c | 19 ++++++++++---------
kernel/auditsc.c     | 10 +++++++---
5 files changed, 21 insertions(+), 17 deletions(-)

-- 
paul-moore.com
