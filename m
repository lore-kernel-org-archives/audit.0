Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3DFCDB47E
	for <audit@archiver.kernel.org>; Thu, 19 Oct 2023 00:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjJSAW2 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 20:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSAW2 (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 20:22:28 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95FCFA
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 17:22:26 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-581e92f615fso1104517eaf.2
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 17:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697674946; x=1698279746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6o6wTNOsZ4BFP12AtUAZBDIHARUG+Z02uoEJrxveRfw=;
        b=EV9hnRw0rdLn8JWGwVqnakAlcGMv8DiKuYC2q0sTGlbHSBMGS+mUyvtllIySLVMH1W
         LIclTvbS4Rr/5dEPzhWLs/xBODJbUlS9imSgZ5Ua4u9hb34Mi4PFutXKCMEbjSJ8nXm4
         +PVPGSPrHkR9H7hOSxYZRy6eT+gVav+hxk6wDndQ6BZeZIcwJw26wEQyanFSCn+iXtwl
         ebtWNO0yEpVsldA1Z3OYWx2gV81PCUWnRAnk2NPDZofJzZbX9YystELCklFNbpersMFo
         a89wxXswzaWuiMzE3bd0uJF0jeW3b8YbHO35YJcDXneulYVJqOmP1iXN8TIwkHZ/RAH7
         f/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697674946; x=1698279746;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o6wTNOsZ4BFP12AtUAZBDIHARUG+Z02uoEJrxveRfw=;
        b=RYWPtXZLZmrB+i9KjH0KNod5VeouOp+ZZSWM1+R/7/b6kx7AXc/BBJ/IXZyQypg8bQ
         ErPZIMkPaPknV3Gsh6DEE1YOGPBpah6PvSA1JgsmRUtsOtGbuHJTnvx/9bvjXf7N8/A1
         k+ehZzhEEYq2gkOsk8eBixv6vtk8vo8SscCZ1qoaqYxKGZ68ybATcWL8dlnXETwIndp3
         aZzZelQfmJq78JKPn2BwdzAFInytft51j8DdMGa05fZwYEy0sJmFkQML9yWtQK2rL4HI
         hKZ5gVK0wuZGVn/q6BqvZYLrXKjfAE9LCklzjvVnNJMnhrkR5Wq1JQW1ZVKJBWDHUvrh
         Pglg==
X-Gm-Message-State: AOJu0YygdC+Gwuc0C6LUSRBC/nx8cHSiv+ESqscdt29PuSh7pQYJOfQ9
        mxpaFHCLSbdpVraAJQpc8JQG8F0nNIeGmLcnNXY=
X-Google-Smtp-Source: AGHT+IFMq3QVt1VaTkhxsSZiDgrNbnXVYUEbW88kD6FohnrSwgg0ZPvQxUUP44mHgiEkBiE2OfRPkjnYAKNciqihTTg=
X-Received: by 2002:a4a:d357:0:b0:56e:466c:7393 with SMTP id
 d23-20020a4ad357000000b0056e466c7393mr660875oos.5.1697674946108; Wed, 18 Oct
 2023 17:22:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Wed, 18 Oct 2023
 17:22:25 -0700 (PDT)
In-Reply-To: <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
References: <20231018222023.371274-2-paul@paul-moore.com> <CAHC9VhTRAugYNG3xwMO2oxy+Wdb_Oo2VkRBRWMnMdiTKij8TUw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Thu, 19 Oct 2023 02:22:25 +0200
Message-ID: <CAGudoHE=RPqcwNh2sEeUF=Dhd=OPpuhbQu1YCJ+V3g1Jhf9JUw@mail.gmail.com>
Subject: Re: [PATCH] audit: use mmget() instead of get_task_exe_file() when
 auditing @current
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org,
        Andreas Steinmetz <anstein99@googlemail.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 10/19/23, Paul Moore <paul@paul-moore.com> wrote:
>> The get_task_exe_file() function locks the given task with task_lock()
>> which when used inside audit_exe_compare() can cause deadlocks on
>> systems that generate audit records when the task_lock() is held.  As
>> we should be able to safely access current->mm we can drop the call to
>> get_task_exe_file() and get a reference to current->mm directly which
>> we can then use in a call to get_mm_exe_file() without having to take
>> task_lock().
>>

I don't follow what's the deadlock.

You mean they hold task lock for current and then call into
audit_exe_compare which takes it again?

I would argue any calls into the routine with *any* task already
locked are fishy at best (I'm assuming there is an established task
lock ordering which may be accidentally violated).

>> While the audit_exe_compare() function takes an arbitrary task_struct
>> parameter, all of the callers outside of fork/clone, call
>> audit_exe_compare() to operate on the current task_struct, making it
>> the common case.  In the fork/clone case, when audit_exe_compare() is
>> called on the child task_struct, it should be safe to use the
>> get_task_mm() function as no other task should be holding task_lock()
>> at this time.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare")
>> Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  kernel/audit_watch.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
>> index 65075f1e4ac8..fa3e6ea0e58c 100644
>> --- a/kernel/audit_watch.c
>> +++ b/kernel/audit_watch.c
>> @@ -526,8 +526,20 @@ int audit_exe_compare(struct task_struct *tsk, struct
>> audit_fsnotify_mark *mark)
>>         struct file *exe_file;
>>         unsigned long ino;
>>         dev_t dev;
>> +       struct mm_struct *mm;
>>
>> -       exe_file = get_task_exe_file(tsk);
>> +       /* almost always operate on current, exceptions for fork/clone */
>> +       if (likely(tsk == current)) {
>> +               mmget(current->mm);
>> +               mm = current->mm;
>> +       } else {
>> +               /* this can deadlock outside the fork/clone usage (see
>> above) */
>> +               mm = get_task_mm(tsk);
>> +               if (!mm)
>> +                       return 0;
>> +       }
>> +       exe_file = get_mm_exe_file(mm);
>> +       mmput(mm);
>>         if (!exe_file)
>>                 return 0;
>>         ino = file_inode(exe_file)->i_ino;

Assuming concerns expressed above are moot, I would hide the logic in
audit_get_task_exe_file or similar.

-- 
Mateusz Guzik <mjguzik gmail.com>
