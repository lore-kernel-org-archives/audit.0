Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC9C7EE22
	for <audit@archiver.kernel.org>; Wed, 10 May 2023 13:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjEJNae (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 10 May 2023 09:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbjEJNac (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 10 May 2023 09:30:32 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FD57AA7
        for <audit@vger.kernel.org>; Wed, 10 May 2023 06:30:29 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34ADUJIN040673;
        Wed, 10 May 2023 22:30:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Wed, 10 May 2023 22:30:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34ADUJhr040670
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 May 2023 22:30:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f2c12d41-95bb-6e56-4d68-8a4b50ca59fd@I-love.SAKURA.ne.jp>
Date:   Wed, 10 May 2023 22:30:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
Content-Language: en-US
To:     Rinat Gadelshin <rgadelsh@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
 <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
 <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
 <415a4871-4d84-a31f-5417-e850a98bbffd@I-love.SAKURA.ne.jp>
 <7c4caf66-a0ae-4999-172e-437d6cfc8ff3@gmail.com>
 <0e748195-d3ba-88c5-1b1e-5a9c447bea57@I-love.SAKURA.ne.jp>
 <dcb7759f-ffd9-b414-f68b-44707a879312@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <dcb7759f-ffd9-b414-f68b-44707a879312@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 2023/05/10 21:12, Rinat Gadelshin wrote:
>> Please try to find who is calling audit_send_reply_thread for many times.
>>
> I've rebuilt the kernel with 'dump stack()'.

Oops, I thought dump_stack() shows pid and comm name, but
it is dump_stack_print_info() that shows pid and comm name.

> As far as I can see, it's the exit of `sendto` syscall.
> It seems that the kernel just creates a new kthreadd for each sendto syscall.
> But I think that I'm wrong and just missing something.

Yes, sendto() on netlink socket calls netlink_sendmsg().
For some reason, audit_send_reply() is called for many times.
audit_send_reply() is called by audit_receive_msg() for the following types.

  AUDIT_GET
  AUDIT_SIGNAL_INFO
  AUDIT_TTY_GET
  AUDIT_GET_FEATURE

Would you re-caputure with

-	dump_stack();
+	pr_info("%s %s:%d type=%d\n", __func__, current->comm, current->pid, type);

?

Regardless of the result of re-caputure, it seems there is no switch that can
prevent audit_send_reply() from calling kthread_run(audit_send_reply_thread).

But since kthreadd runs with PID=2 and PPID=0, you might be able to use
PID=2 and/or PPID=0 in your rules in order to let kernel audit subsystem
ignore kthreadd. (I can't test because I haven't found how to reproduce
audit_receive_msg() in my environment...)

# cat /proc/2/status
Name:   kthreadd
Umask:  0000
State:  S (sleeping)
Tgid:   2
Ngid:   0
Pid:    2
PPid:   0

