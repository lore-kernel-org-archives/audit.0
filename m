Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EF4C77B7D
	for <audit@archiver.kernel.org>; Wed, 10 May 2023 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjEJMM4 (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 10 May 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjEJMMz (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 10 May 2023 08:12:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A65FD2
        for <audit@vger.kernel.org>; Wed, 10 May 2023 05:12:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ad89c7a84fso46476581fa.2
        for <audit@vger.kernel.org>; Wed, 10 May 2023 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683720772; x=1686312772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0AZ2WR1sgJtd+4MNio4ClHfbROcFaWDkZ1fPB/VSB0=;
        b=lZcy0UXLtNUtsvaKu2NE7LkBlj/BUMCGczrxs7XpNYAm9bhOmHCfKIECB7J/WCeyeE
         D/Bvd4K6nkL4S7PAGFRdFCjrAYZY2GrY8xdyA0w94HjQRzrr/MgcRk1b1T2jNJxs+SUv
         tMJmqLy9+v+0TSKf5O4KnbpW4roBTVUVelM7c4l3GFa/cE47e4URX+QDXoOMxXluS4rU
         +kz2TXLNgBjE9eewNhPlZdJRaf2HQjzrxf9XXh6ZCQNGGaPGql6qbPzMW/4Pmj94eNxs
         NSKhc0ap8mwIbwLnNvwJbQeRaeu01fyoaUfS3PwehKJSSleG42vOe032Sa2lcOaQ2hgv
         bdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683720772; x=1686312772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0AZ2WR1sgJtd+4MNio4ClHfbROcFaWDkZ1fPB/VSB0=;
        b=dKmY9Mr1n9cERUtj9EvlsHgIA7kzLTvbpuMj2GRiM1smhlonujz3jvek0lQrz+Pr2M
         0vdNIsksU0lbEDqhUdkrcPwiQx2CrPcar8+2AlVD0xhZ1HjpM70vp+l/KVn3oJFpML5w
         J2iN2QDvpOeNT8X+mgKb5I23TNZ0uf4fqAWnVnRe4BBXGKs2tSNZp5ZG41y7lDBv/bXM
         oc3qvaNisHm/z+lieQodGJ0qDZLrSlu5g3hTi7UbcBx1l8AF5YEewzp4fXCGxoFlc0Pf
         HYXD5y/KdhLIPUMkWnU2o+RD5F1YKLAdW0czAjeg3ORERIK8YDmMPOuJlWcG4o+J6KDr
         41cQ==
X-Gm-Message-State: AC+VfDxS84MoY/Kb/xQhyMzY3rcSw2cHxeenXM/a2rwTAYyjzvmWJJNo
        ++LB+p3g7+pzZO/fa1VvHbVDTwrxNjzDsW3b
X-Google-Smtp-Source: ACHHUZ5pfkcrY6RsZ+cbJqucDC6oMiMwmqlMaoA3dGh1T0ycOK9MDch6w729yiRp0IHcCYv99FYxvA==
X-Received: by 2002:a2e:9916:0:b0:2ac:689e:241b with SMTP id v22-20020a2e9916000000b002ac689e241bmr2008919lji.47.1683720772413;
        Wed, 10 May 2023 05:12:52 -0700 (PDT)
Received: from [192.168.0.31] ([94.242.171.95])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e2e0a000000b002ad9df0586bsm762382lju.132.2023.05.10.05.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:12:52 -0700 (PDT)
Message-ID: <dcb7759f-ffd9-b414-f68b-44707a879312@gmail.com>
Date:   Wed, 10 May 2023 15:12:51 +0300
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
 <7c4caf66-a0ae-4999-172e-437d6cfc8ff3@gmail.com>
 <0e748195-d3ba-88c5-1b1e-5a9c447bea57@I-love.SAKURA.ne.jp>
Content-Language: en-US, ru-RU
From:   Rinat Gadelshin <rgadelsh@gmail.com>
In-Reply-To: <0e748195-d3ba-88c5-1b1e-5a9c447bea57@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org


On 06.05.2023 09:50, Tetsuo Handa wrote:
> On 2023/05/06 7:12, Rinat Gadelshin wrote:
>> The only one `auditctl -l` request was performed.
>> I see the following response in syslog for the request:
> Thanks for rules.
>
> I tried "auditctl -l" with these rules, and I got only
>
>    audit: Started audit_send_list_thread
>    audit: Calling netlink_unicast (repeated for 32 times)
>    audit: Finished audit_send_list_thread
>
> as output; audit_send_reply_thread is not called in my environment.
>
> That is, for some reason (maybe some process is interfering each other)
> audit_send_reply_thread is needlessly called in your environment?
> In that case, fixing the cause of audit_send_reply_thread being called
> could reduce the spam.
>
> Please try to find who is calling audit_send_reply_thread for many times.
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..bf4fef7da692 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1006,6 +1011,7 @@ static void audit_send_reply(struct sk_buff *request_skb, int seq, int type, int
>   	tsk = kthread_run(audit_send_reply_thread, reply, "audit_send_reply");
>   	if (IS_ERR(tsk))
>   		goto err;
> +	dump_stack();
>   
>   	return;

Hi Tetsuo,

I've rebuilt the kernel with 'dump stack()'.

I've got 7 call stacks for the same test (`auditctl -l` and the same 
audit rule list), they are all similar to:

May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025922] audit: Started 
audit_send_reply_thread
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025924] Hardware name: 
LENOVO 21AH00BPUS/21AH00BPUS, BIOS N3MET11W (1.10 ) 12/07/2022
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025926] Call Trace:
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025928]  <TASK>
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025929] 
dump_stack_lvl+0x4c/0x70
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025935] dump_stack+0x14/0x20
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025936] 
audit_send_reply.constprop.0+0xcc/0x120
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025939] 
audit_receive_msg+0x26d/0x1070
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025940]  ? 
string_nocheck+0x4f/0x60
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025942]  ? string+0x4e/0x60
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025943] 
audit_receive+0xb9/0x180
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025944]  ? 
netlink_deliver_tap+0x49/0x250
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025947] 
netlink_unicast+0x1b2/0x260
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025948] 
netlink_sendmsg+0x254/0x4d0
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025950] 
sock_sendmsg+0x9d/0xb0
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025952] 
__sys_sendto+0x122/0x1b0
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025954]  ? 
__handle_mm_fault+0xac0/0xd10
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025956]  ? 
__audit_syscall_entry+0xd2/0x140
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025958] 
__x64_sys_sendto+0x2d/0x40
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025959] 
do_syscall_64+0x5d/0x90
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025962]  ? 
exit_to_user_mode_prepare+0x3d/0x190
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025965]  ? 
do_user_addr_fault+0x1bc/0x8a0
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025967]  ? 
irqentry_exit_to_user_mode+0xd/0x20
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025969]  ? 
irqentry_exit+0x3f/0x50
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025970]  ? 
exc_page_fault+0x8e/0x190
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025971] 
entry_SYSCALL_64_after_hwframe+0x72/0xdc
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025974] RIP: 
0033:0x7fe97af368a4
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025976] Code: c2 f7 ff ff 
44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 
00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 30 89 
ef 48 89 44 24 08 e8 e8 f7 ff ff 48 8b
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025977] RSP: 
002b:00007ffdfc78af50 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025979] RAX: 
ffffffffffffffda RBX: 00007fe90900aee0 RCX: 00007fe97af368a4
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025980] RDX: 
0000000000000010 RSI: 00007fe90900aff8 RDI: 0000000000000008
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025981] RBP: 
0000000000000000 R08: 00007ffdfc78afd4 R09: 000000000000000c
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025981] R10: 
0000000000000000 R11: 0000000000000293 R12: 00007fe944461920
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025982] R13: 
00007fe905b31be0 R14: 00007fe905b31bf0 R15: 0000000000000000
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025984] </TASK>
May 10 14:51:52 gadelshin-ri-nb kernel: [ 9381.025989] audit: Finished 
audit_send_reply_thread


As far as I can see, it's the exit of `sendto` syscall.
It seems that the kernel just creates a new kthreadd for each sendto 
syscall.
But I think that I'm wrong and just missing something.

