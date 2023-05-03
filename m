Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B9C77B78
	for <audit@archiver.kernel.org>; Wed,  3 May 2023 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjECWMZ (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 3 May 2023 18:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECWMZ (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 3 May 2023 18:12:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D883D7
        for <audit@vger.kernel.org>; Wed,  3 May 2023 15:12:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so6772577e87.2
        for <audit@vger.kernel.org>; Wed, 03 May 2023 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683151942; x=1685743942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmJV+5KKP6ZleB1YiKlxYeo/FavUxOXpB7BbSpovIXs=;
        b=p4+7v0MxiTyslqfC61nTI2iSIqbEWfKgviDz+vvsKsA0CyBJ3+YmovV9AWAwhIbaDM
         maLRF44/7P+CYltNpOTJCU8huMX4j0jlb1dgOA3DxxwZeHih59y9BC0tVWTr5zrZU8Ah
         M+FgWBqEffJZalI7lsrVhECSJlLsFoJMpYoMyYtWl/BsXrMNQ1a5oULTfzBAU8pdJ9u8
         1xro7b2RPlx4riTGjWggmoRtrlD8o8Ges56D4VpBIDVi+/9DuStYK+B2HwnAmTTP3kFG
         wOMDnw73HGVd47OVGqhqcETo+O+FSWjHg+P6YLhDjgHpar67cVTjGntAaA+7Vujh4xrf
         8/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683151942; x=1685743942;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmJV+5KKP6ZleB1YiKlxYeo/FavUxOXpB7BbSpovIXs=;
        b=dkXmRYRIZm6vk3kFy2m6vXykVlMZfO24/pgWaQ1gX/SeGZaXW8RyO4LYenO8kEyBHY
         KwztUPJtHsrQq+vGBEmVmgEhGTfKVMj7n/FrKSc9a/4OKemrlYMdRfklP+19JuiFXl7h
         hrFtVLZ4Ws8TL3Z3QtdqhROOKnRy+obAuDXKlmmONaBHM+r9JI3Xhb0UwnrmNGlmNEP8
         40CRKmyQJyRSyZrZKPuhRFK7OO+aed2U3K8qRJxcfeBJDOE8w/fyqEGIsg9ap5OTcMSL
         lLic3FArcunMaapTspDZu9HsBq41hrP67gZAwF/OuLgJ/vr8tjNXAVnyu1ylzUwpDOpm
         49RA==
X-Gm-Message-State: AC+VfDyPnLbwxBSFaut78RgCnxcAvdeulG7KAZAivZ7I8hRZuQO2wQyJ
        8ZZeYqqX/Fn+4w0lC7daII1k9P+uwdBi4A==
X-Google-Smtp-Source: ACHHUZ7SlB2sz4xex/XkRZVAVRIMDkKkZmhtb8ZSrwuaIlZyYvUiJFfySG5D7iEGAu4GIqSDgtHa0A==
X-Received: by 2002:ac2:5467:0:b0:4eb:252e:3ec5 with SMTP id e7-20020ac25467000000b004eb252e3ec5mr1205720lfn.14.1683151941622;
        Wed, 03 May 2023 15:12:21 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.165])
        by smtp.gmail.com with ESMTPSA id c8-20020ac24148000000b004edc20b8929sm6212595lfi.69.2023.05.03.15.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 15:12:21 -0700 (PDT)
Message-ID: <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
Date:   Thu, 4 May 2023 01:12:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
Content-Language: en-US, ru-RU
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 04.05.2023 00:27, Paul Moore wrote:
> On Wed, May 3, 2023 at 5:14 PM Rinat Gadelshin <rgadelsh@gmail.com> wrote:
>> Hello there =)
>>
>> My name is Rinat.
>> I'm a newbie here (at Linux kernel developer community).
>>
>> My current job is to work with audit subsystem on different
>> versions of Linux (and different kernel versions from 3.10 to the latest)
>> with and without auditd.
>>
>> My program works behalf of root account and uses netlink
>> (unicast or multicast depends of  the kernel's version)
>> to communicate with audit subsystem of the kernel.
>>
>> If actual audit rule list has been changed
>> then my program should restore the configured audit rule list.
>>
>> To do it the program periodically (with 60 seconds interval)
>> requests the actual rule list be sending AUDIT_LIST_RULES.
>>
>> All rules are receiving perfectly.
>>
>> But I've noticed that there are many (2K+ for 5 minutes test)
>> kthreadd process have been spawned after that request
>> (I've stubbed the poll code and compare logs).
> Hi Rinat,
>
> First, a quick note that audit discussions involving the upstream
> Linux Kernel have moved to the audit@vger.kernel.org list (CC'd),
> please direct future emails there.
>
> Can you be more specific about the kernel threads you are seeing, are
> you seeing multiple "kauditd" threads?
>
> % ps -fC kauditd
> UID          PID    PPID  C STIME TTY          TIME CMD
> root          89       2  0 Apr28 ?        00:00:00 [kauditd]
>
>> Please, can you point me, what can I do to avoid this kthreadd-spam.
>>
>> Thank you.
>>
>> Best regards
>> Rinath
Hi Paul,

Thank you for your quick answer.
I swear to copy my future questions about audit subsystem to 
audit@vger.kernel.org =)

My logs don't provide lot of info about nature of the kthreadds.
(I hadn't written the log system).

I have something like this:

...pid: 2, uniquePid: 000082d800000002, fileName: kthreadd, lcFileName: 
kthreadd, name: kthreadd, commandLine: Skipped, lcCommandLine: Skipped, 
sessionId: 0, isRemote: 0, syscallName: fork, uid: 4294967295, gid: 
4294967295, euid: 4294967295, egid: 4294967295, logonSessionUid: -1, 
logonSessionUsername: Skipped, logonSessionRemoteHost: , exeOwnerUid: 0, 
exeOwnerGid: 0, exeMode: 0, exeInode: 0, exeCapsVersion: , 
exeCapsRootId: , exeCapsEffective: , exeCapsPermitted: , 
exeCapsInheritable: , dstPid: 106574, dstTid: 0, dstUniquePid: 
000083b10001a04e, requestId: 2684354949, startTime: 01d97d1fb24aa38e, 
hash: 00000000000000000000000000000000, cwd: , flags: 00000011, 
processState: 3, int: 0, type: 00000000..

And such events occurred 1208 times when AUDIT_LIST_RULES is sending.
The test has lasted 2 minutes.

The same test in which the request was disabled produced only 122 such 
records.

It was the only difference between the tests.

As I can see it was a fork syscall of kthreadd.

Are there any debug options for the kernel that I can set, rebuild the 
kernel, re-run the test and clarify the situation?

