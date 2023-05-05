Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2F6C77B7C
	for <audit@archiver.kernel.org>; Fri,  5 May 2023 22:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjEEWM2 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 5 May 2023 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEEWM1 (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 5 May 2023 18:12:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC546A6
        for <audit@vger.kernel.org>; Fri,  5 May 2023 15:12:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f13c577e36so2597040e87.1
        for <audit@vger.kernel.org>; Fri, 05 May 2023 15:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324744; x=1685916744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvwH/om6riyO67KuORkjhn7D8bd2EIUB1tcKOP2bv8w=;
        b=P/jX61iU4sj1X3+G0O1I2VdoZiOVuGsFhc9t/gb9NTLOMV2BaT5lfBJURCujYGVLJr
         Ivl1xAOTrPk44dcFgM6Sj56Q6Wir6dIP9LVHey3s5FEH4HaHzeai/fJmuYIfkb2XOl0i
         jU4JNiGeAuejVpIdz8KVd06GjAaTxBLhChBU8REWp3e5/SuROosaSgs5xJDfJth/yvL1
         ByfhIPe2sdohOXX15dhkeUpEoCMvZyBj9OIThbbuHI/qUjkqH6QLD/R3t7x3jaWm9rgj
         2rpjaVSKjDjjEpReOAw80efRzgykmbuIdprTp0VBLIGXBC2wSKxByiwB6SCCIKOckt14
         B9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324744; x=1685916744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvwH/om6riyO67KuORkjhn7D8bd2EIUB1tcKOP2bv8w=;
        b=cZuZ5C+g5rDS5RTWsxOweX0lHBQ377CqomM9VxdTzK/GBu8XYujTj6QCcnMOLg4aUQ
         4v5WnrRjoipyjVzBWd+2rE1ZgbewrP8BzNkqYtSu5RNoNuxVhfqlcBwI3OLnrsAG2K46
         uij0I9P/AG7bjo4lCa314cpwn3byEcoVQ/Ln5KSJ1QUj1wlEFba+R/yFU9XA3pXRENFR
         FDm0K7DoE8+7e5kLJLzU/ZkASnOGeWHf9iSnWndIOt5QNVQysTzMaPVsDkNo1MgmEEiE
         /uFn66coQJGn1eGZTAARoGBYsDw22MGkYAcWjt7oe8SrjunOGb+Mtn/Z+vYYsdgY7ZGa
         M+7A==
X-Gm-Message-State: AC+VfDyGFxrf+MAEIMokCACEOUXJk7TfreSmwDzzBESdVlTHtwvL7z90
        2t02OcLJWeGYV/JUbuNKjZs=
X-Google-Smtp-Source: ACHHUZ4dPDxP/8+k+DX0YtlzfqnFMES5FF+Vr0TwXxTT/asT8GQ0seC0pv55tjxY7JZVO+zcLj7O2g==
X-Received: by 2002:ac2:5213:0:b0:4d8:4f46:f0b9 with SMTP id a19-20020ac25213000000b004d84f46f0b9mr872406lfl.23.1683324743929;
        Fri, 05 May 2023 15:12:23 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.165])
        by smtp.gmail.com with ESMTPSA id x22-20020ac24896000000b004db297957e8sm426674lfc.305.2023.05.05.15.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 15:12:23 -0700 (PDT)
Message-ID: <7c4caf66-a0ae-4999-172e-437d6cfc8ff3@gmail.com>
Date:   Sat, 6 May 2023 01:12:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
 <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
 <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
 <415a4871-4d84-a31f-5417-e850a98bbffd@I-love.SAKURA.ne.jp>
Content-Language: en-US, ru-RU
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <415a4871-4d84-a31f-5417-e850a98bbffd@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 05.05.2023 01:53, Tetsuo Handa wrote:
> On 2023/05/05 3:40, Paul Moore wrote:
>> On Wed, May 3, 2023 at 10:50 PM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> On 2023/05/04 7:12, Rinat Gadelshin wrote:
>>>> On 04.05.2023 00:27, Paul Moore wrote:
>>>>> Can you be more specific about the kernel threads you are seeing, are
>>>>> you seeing multiple "kauditd" threads?
>>>>>
>>>>> % ps -fC kauditd
>>>>> UID          PID    PPID  C STIME TTY          TIME CMD
>>>>> root          89       2  0 Apr28 ?        00:00:00 [kauditd]
>>> I don't think so.
>>>
>>> kernel audit subsystem uses kthread_run() in order to run short-lived kernel threads.
>> Thanks Tetsuo, I agree that's far more likely.  Ever since I took over
>> shepherding the audit code, all of the thread issues have been around
>> the main audit queue thread so it's a bit reflexive to assume that is
>> the case :)
>>
> Since kthread_run(audit_send_list_thread) is called by audit_receive_msg(AUDIT_LIST_RULES)
> via audit_list_rules_send(), trying to audit fork request via AUDIT_LIST_RULES will cause
> spams. Maybe something is going wrong with "And such events occurred 1208 times when
> AUDIT_LIST_RULES is sending." part; let's wait for what printk() says.
>
> By the way, why do we need to use kthread_run() for short-lived tasks? Can't we use
> a dedicated workqueue which would significantly reduce frequency of fork request for
> AUDIT_LIST_RULES request?
>
Hello there =)
Sorry for my long absence.

I've managed to build and install the custom kernel (from Linus' branch 
with Tetsuo's patch for logging).

The following rules were dictated by my netlink (with disabled poll 
rule's logic:

-a always,exit -F arch=b32 -S fork,execve,clone,vfork,execveat
-a always,exit -F arch=b64 -S clone,fork,vfork,execve,execveat
-a never,exit -F pid=4641
-a never,exit -F ppid=4641
-a never,exit -F pid=1
-a never,exit -F ppid=1
-a always,exit -F arch=b64 -S kill,ptrace
-a always,exit -F arch=b32 -S ptrace,kill
-a always,exit -F arch=b64 -S exit,exit_group
-a always,exit -F arch=b32 -S exit,exit_group
-a always,exit -F arch=b64 -S connect,accept,accept4
-a always,exit -F arch=b32 -S connect,accept4
-a always,exit -F arch=b64 -S open,creat,openat,437
-a always,exit -F arch=b64 -S rename,renameat,renameat2
-a always,exit -F arch=b32 -S rename,renameat,renameat2
-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat
-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat
-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat
-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat
-a always,exit -F arch=b64 -S link,symlink,linkat,symlinkat
-a always,exit -F arch=b32 -S link,symlink,linkat,symlinkat
-a always,exit -F arch=b64 -S mount,umount2
-a always,exit -F arch=b32 -S mount,umount,umount2
-a always,exit -F arch=b64 -S 
setuid,setgid,setreuid,setregid,setresuid,setresgid
-a always,exit -F arch=b32 -S 
setuid,setgid,setreuid,setregid,setresuid,setresgid
-a always,exit -F arch=b64 -S mmap,mprotect -F a2=0x7
-a always,exit -F arch=b32 -S mmap,mprotect -F a2=0x7
-a always,exit -F arch=b64 -S unlink,unlinkat
-a always,exit -F arch=b32 -S unlink,unlinkat
-a always,exit -F arch=b64 -S ioctl -F a2=0x40086602
-a always,exit -F arch=b32 -S ioctl -F a2=0x40086602

The only one `auditctl -l` request was performed.
I see the following response in syslog for the request:

May  6 01:01:19 gadelshin-ri-nb kernel: [  110.474111] audit: Started 
audit_send_reply_thread
May  6 01:01:19 gadelshin-ri-nb kernel: [  110.474123] audit: Finished 
audit_send_reply_thread
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972014] audit: Started 
audit_send_list_thread
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972020] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972023] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972023] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972024] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972025] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972026] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972026] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972027] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972028] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972029] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972029] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972030] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972030] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972031] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972032] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972032] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972033] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972034] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972034] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972035] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972035] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972036] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972037] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972038] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972038] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972039] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972039] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972040] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972040] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972041] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972042] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972043] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972044] audit: Calling 
netlink unicast
May  6 01:01:20 gadelshin-ri-nb kernel: [  111.972045] audit: Finished 
audit_send_list_thread
May  6 01:01:21 gadelshin-ri-nb kernel: [  112.485659] audit: Started 
audit_send_reply_thread
May  6 01:01:21 gadelshin-ri-nb kernel: [  112.485689] audit: Finished 
audit_send_reply_thread
May  6 01:01:23 gadelshin-ri-nb kernel: [  114.501072] audit: Started 
audit_send_reply_thread
May  6 01:01:23 gadelshin-ri-nb kernel: [  114.501076] audit: Finished 
audit_send_reply_thread
May  6 01:01:24 gadelshin-ri-nb auditd[1210]: Audit daemon rotating log 
files
May  6 01:01:25 gadelshin-ri-nb kernel: [  116.506645] audit: Started 
audit_send_reply_thread
May  6 01:01:25 gadelshin-ri-nb kernel: [  116.506656] audit: Finished 
audit_send_reply_thread
May  6 01:01:27 gadelshin-ri-nb kernel: [  118.512282] audit: Started 
audit_send_reply_thread
May  6 01:01:27 gadelshin-ri-nb kernel: [  118.512306] audit: Finished 
audit_send_reply_thread

`git describes` shows: v6.3-13027-g1a5304fecee5
Distributive is  Ubuntu 20.04 (x64)

