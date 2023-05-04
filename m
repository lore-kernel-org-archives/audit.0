Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6024AC7EE21
	for <audit@archiver.kernel.org>; Thu,  4 May 2023 22:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEDWxz (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 4 May 2023 18:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDWxy (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 4 May 2023 18:53:54 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B9F11B5E
        for <audit@vger.kernel.org>; Thu,  4 May 2023 15:53:53 -0700 (PDT)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 344MrhGv079515;
        Fri, 5 May 2023 07:53:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Fri, 05 May 2023 07:53:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 344Mrh38079512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 May 2023 07:53:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <415a4871-4d84-a31f-5417-e850a98bbffd@I-love.SAKURA.ne.jp>
Date:   Fri, 5 May 2023 07:53:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Rinat Gadelshin <rgadelsh@gmail.com>, audit@vger.kernel.org,
        linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
 <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
 <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 2023/05/05 3:40, Paul Moore wrote:
> On Wed, May 3, 2023 at 10:50 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2023/05/04 7:12, Rinat Gadelshin wrote:
>>> On 04.05.2023 00:27, Paul Moore wrote:
>>>> Can you be more specific about the kernel threads you are seeing, are
>>>> you seeing multiple "kauditd" threads?
>>>>
>>>> % ps -fC kauditd
>>>> UID          PID    PPID  C STIME TTY          TIME CMD
>>>> root          89       2  0 Apr28 ?        00:00:00 [kauditd]
>>
>> I don't think so.
>>
>> kernel audit subsystem uses kthread_run() in order to run short-lived kernel threads.
> 
> Thanks Tetsuo, I agree that's far more likely.  Ever since I took over
> shepherding the audit code, all of the thread issues have been around
> the main audit queue thread so it's a bit reflexive to assume that is
> the case :)
> 

Since kthread_run(audit_send_list_thread) is called by audit_receive_msg(AUDIT_LIST_RULES)
via audit_list_rules_send(), trying to audit fork request via AUDIT_LIST_RULES will cause
spams. Maybe something is going wrong with "And such events occurred 1208 times when
AUDIT_LIST_RULES is sending." part; let's wait for what printk() says.

By the way, why do we need to use kthread_run() for short-lived tasks? Can't we use
a dedicated workqueue which would significantly reduce frequency of fork request for
AUDIT_LIST_RULES request?

