Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B386EB64DC
	for <audit@archiver.kernel.org>; Mon, 26 Jun 2023 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFZU5i (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZU5h (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 26 Jun 2023 16:57:37 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036012A
        for <audit@vger.kernel.org>; Mon, 26 Jun 2023 13:57:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-570808d8ddeso42215467b3.0
        for <audit@vger.kernel.org>; Mon, 26 Jun 2023 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1687813054; x=1690405054;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kfxo+qeDQtE6pfqX2pSVRn4Ktm5TmTSx9jMdiyp1OT4=;
        b=XpIIXT1JP95o4USFFOxXJXcoIrgMALNoGaOpjXNUYPtNxL7AVGgjNT6tncC8SlNk8a
         CnOjClmdLziA56k70SuTLjis8gL0y+NTFNoRD/lyp/e1Q6RLilOSBu9xwRv0TKPTFYr3
         P2Cq9DNnieb5kUuX/V+XO8r0C5u4fMJKtAFhl74uh4Ki56mSMca6ZrnGh8B6Z7suZlrA
         Z64D+gn2ajp29P3YJ0aoDE75vvLTMtQz9kNcR8nsqOlRMrt6kcDXERIsIEy986yU/daH
         gPo91Efo56Z73JxuTvfrRwedHJT15lWBCDgcNbNcuTY61aqTSV7eikyJig1lQAluz3ZH
         GfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813054; x=1690405054;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfxo+qeDQtE6pfqX2pSVRn4Ktm5TmTSx9jMdiyp1OT4=;
        b=XG6vpFu4wmZ+N/TP+xOueL3YidgpoZwvkiWLsVwEtsSocqF5APZYfd10rJ++epETR4
         fiCH2jgxVWC9u/baQXyo7Z1Gby1BGJGPhPyxuicDJyL6gUC6+ANGr2hRFrnxffKP6utU
         gk7WabEkmZ+Au/fw7aZ8OvAqnmgPGJYQukQL7MRlceD6MAkeb8kg9oO/+A+RjjfmgoD5
         6S8/i8X1MNVa8+bd2Fko5YMKLmTbwx4LMktWGWFbEK+H3OoUh6ULGCLfMmIC626ihs4/
         /HKAvahKWOwacj5HyhBhDKcWZgxesYLWzTTYoSdguiWrDwm5J68sgfPaNYylnKnxn2hc
         alfg==
X-Gm-Message-State: AC+VfDx0OrNGiuwl/P/M1FAztOlx5I40ljatDy1pJ/p/3bORpuP+w+ve
        xXBtd8B2MzATCy3mrHwZjcN0jQtjoHXcAuI2EccxLXzkERqT0wg2ug==
X-Google-Smtp-Source: ACHHUZ6ZyOU0JoT8cNBcFBcx5J+DrrL8BN+fGLFUQjVOnsFRFC3jsF+bemFQsyMFGAHKSXzDBI4TNpCJZCtTZ1xUNZI=
X-Received: by 2002:a81:e943:0:b0:576:916d:96b with SMTP id
 e3-20020a81e943000000b00576916d096bmr9971637ywm.36.1687813054539; Mon, 26 Jun
 2023 13:57:34 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Jun 2023 16:57:23 -0400
Message-ID: <CAHC9VhTcPVRAoxWn+EpMcGPThgtfhB=z3LM3BkMtxKv6aQYPFw@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hi Linus,

A single audit patch for the Linux v6.5 merge window that resolves two
compiler warnings regarding missing function prototypes.  Please
merge.

Thanks,
-Paul

--
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

 Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20230626

for you to fetch changes up to e455ca40dbcf2cd50d1e59bf4b2752b300bcdad4:

 audit: avoid missing-prototype warnings (2023-05-17 11:34:55 -0400)

----------------------------------------------------------------
audit/stable-6.5 PR 20230626

----------------------------------------------------------------
Arnd Bergmann (1):
     audit: avoid missing-prototype warnings

include/linux/audit.h      | 2 --
include/linux/audit_arch.h | 2 ++
kernel/audit.h             | 2 +-
3 files changed, 3 insertions(+), 3 deletions(-)

-- 
paul-moore.com
