Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B50E81806
	for <audit@archiver.kernel.org>; Tue, 26 Sep 2023 01:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIZBZk (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 25 Sep 2023 21:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjIZBZi (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 25 Sep 2023 21:25:38 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A210E
        for <audit@vger.kernel.org>; Mon, 25 Sep 2023 18:25:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-415155b2796so118411cf.1
        for <audit@vger.kernel.org>; Mon, 25 Sep 2023 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695691530; x=1696296330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyCpZ2COuPnq3u0ySYqouIrFNk/fNQ6fhomFET4yGao=;
        b=rjXEHKcFvK7ESpqb10ShophgBbObb2FCexbAK0Lpd3eW2SO55pOZ7SGoXM1flx/9Ju
         IF6eiunKz48IBTS3tvz2sWDTK/jvRbTi/Iku/pEBpkDSXayHcSJ2hmdgpSOUvM+JQo2M
         YZLVwowsg8wgAWiiod4LRDg4qd+qDX3snVrGXU9nQL35W4TDoEZSjrOfD0JuR33q6Fxc
         4YVCPXzLtd+/tbTDugP6d8OTw6FgxjN1u43a9HfKu3Hort5/YuslAEwvkqihPk16WyQS
         /bQpUbItG/XJ97gxbCBzpvTIDHXNok9DbsEA0pdJl0TFjTCaSueRCEvOuTe7emBXOjWk
         vHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695691530; x=1696296330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyCpZ2COuPnq3u0ySYqouIrFNk/fNQ6fhomFET4yGao=;
        b=ZkfkrdRRqxFlzEBweYGFu/RQiBFZX7oB70zFnkBG8onEP2/9wQH17xYi3TOPkHjJm9
         5O8cUGEDfdJT+vCPhtqnyKkgZL+m7Eno+fMpNNKOBcjrsULWnrczc2SByBmSzlcf90LP
         aD7C2K09BLHON7G0nLyyYbnZGuIU+gbSS2uL4k2gsnz9leMjBg5fDQ83nK6010ieKlSr
         z9A7mfAe3wILyDTdipVv5uI9o/MwfWb1F8DiIUzRvpVPKMhEtwVOsjPgZr/pRQesh1aA
         M9LU5DDV3bBPCT6JqvTNiwTXB26wB47vfeoOcOPnEos0IUCLK7x9iNtt/QupKZHEQC9z
         nTMA==
X-Gm-Message-State: AOJu0YwVh/Aql9PiRu8CMDRLn2LmiRzsJ/uRDsCbJxhqJbS+yiWBKqsp
        NvKaFATs196tGNVvVC9iFp4Ex1l/S/woGIU8zkguaiEOHt6IcpbHdSE=
X-Google-Smtp-Source: AGHT+IFI4RXEux3TUcu9G4GTXmfcDUwhfA0BROcu+HOUCNvN/WudrlcKISSj7CPA41AqbRndcuvV0Biq/U8nBtDMEnA=
X-Received: by 2002:a05:622a:1ba7:b0:40f:d3db:f328 with SMTP id
 bp39-20020a05622a1ba700b0040fd3dbf328mr144808qtb.2.1695691530295; Mon, 25 Sep
 2023 18:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Mon, 25 Sep 2023 18:24:53 -0700
Message-ID: <CALmYWFvf0FN9QHQ15m+i8Br5DPjsxpJ6wDvhRFBDXd5nbybYRw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/7] Landlock audit support
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hi Micka=C3=ABl

On Wed, Sep 20, 2023 at 11:16=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Hi,
>
> This patch series adds basic audit support to Landlock for most actions.
> Logging denied requests is useful for different use cases:
> * app developers: to ease and speed up sandboxing support
> * power users: to understand denials
> * sysadmins: to look for users' issues
> * tailored distro maintainers: to get usage metrics from their fleet
> * security experts: to detect attack attempts
>
This is a highly desired feature, I think this will save dev's time
when developing Landlock rule sets.
Thanks for adding this patch set!


-Jeff

> To make logs useful, they need to contain the most relevant Landlock
> domain that denied an action, and the reason. This translates to the
> latest nested domain and the related missing access rights.
>
> Two "Landlock permissions" are used to describe mandatory restrictions
> enforced on all domains:
> * fs_layout: change the view of filesystem with mount operations.
> * ptrace: tamper with a process.
>
> Here is an example of logs, result of the sandboxer activity:
> tid=3D267 comm=3D"sandboxer" op=3Dcreate-ruleset ruleset=3D1 handled_acce=
ss_fs=3Dexecute,write_file,read_file,read_dir,remove_dir,remove_file,make_c=
har,make_dir,make_reg,make_sock,make_fifo,make_block,make_sym,refer,truncat=
e
> tid=3D267 comm=3D"sandboxer" op=3Drestrict-self domain=3D2 ruleset=3D1 pa=
rent=3D0
> op=3Drelease-ruleset ruleset=3D1
> tid=3D267 comm=3D"bash" domain=3D2 op=3Dopen errno=3D13 missing-fs-access=
es=3Dwrite_file,read_file missing-permission=3D path=3D"/dev/tty" dev=3D"de=
vtmpfs" ino=3D9
> tid=3D268 comm=3D"ls" domain=3D2 op=3Dopen errno=3D13 missing-fs-accesses=
=3Dread_dir missing-permission=3D path=3D"/" dev=3D"vda2" ino=3D256
> tid=3D269 comm=3D"touch" domain=3D2 op=3Dmknod errno=3D13 missing-fs-acce=
sses=3Dmake_reg missing-permission=3D path=3D"/" dev=3D"vda2" ino=3D256
> tid=3D270 comm=3D"umount" domain=3D2 op=3Dumount errno=3D1 missing-fs-acc=
esses=3D missing-permission=3Dfs_layout name=3D"/" dev=3D"tmpfs" ino=3D1
> tid=3D271 comm=3D"strace" domain=3D2 op=3Dptrace errno=3D1 missing-fs-acc=
esses=3D missing-permission=3Dptrace opid=3D1 ocomm=3D"systemd"
>
> As highlighted in comments, support for audit is not complete yet with
> this series: some actions are not logged (e.g. file reparenting), and
> rule additions are not logged neither.
>
> I'm also not sure if we need to have seccomp-like features such as
> SECCOMP_FILTER_FLAG_LOG, SECCOMP_RET_LOG, and
> /proc/sys/kernel/seccomp/actions_logged
>
> I'd like to get some early feedback on this proposal.
>
> This series is based on v6.6-rc2
>
> Regards,
>
> Micka=C3=ABl Sala=C3=BCn (7):
>   lsm: Add audit_log_lsm_data() helper
>   landlock: Factor out check_access_path()
>   landlock: Log ruleset creation and release
>   landlock: Log domain creation and enforcement
>   landlock: Log file-related requests
>   landlock: Log mount-related requests
>   landlock: Log ptrace requests
>
>  include/linux/lsm_audit.h    |   2 +
>  include/uapi/linux/audit.h   |   1 +
>  security/landlock/Makefile   |   2 +
>  security/landlock/audit.c    | 283 +++++++++++++++++++++++++++++++++++
>  security/landlock/audit.h    |  88 +++++++++++
>  security/landlock/fs.c       | 169 ++++++++++++++++-----
>  security/landlock/ptrace.c   |  47 +++++-
>  security/landlock/ruleset.c  |   6 +
>  security/landlock/ruleset.h  |  10 ++
>  security/landlock/syscalls.c |  12 ++
>  security/lsm_audit.c         |  26 ++--
>  11 files changed, 595 insertions(+), 51 deletions(-)
>  create mode 100644 security/landlock/audit.c
>  create mode 100644 security/landlock/audit.h
>
>
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> --
> 2.42.0
>
