Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D485CDB47E
	for <audit@archiver.kernel.org>; Wed, 18 Oct 2023 20:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJRUfC (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 18 Oct 2023 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjJRUfA (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 18 Oct 2023 16:35:00 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD411A4
        for <audit@vger.kernel.org>; Wed, 18 Oct 2023 13:34:58 -0700 (PDT)
Received: from [192.168.192.84] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C6A823F6B9;
        Wed, 18 Oct 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697661295;
        bh=IGU83iirYSaaxUWj3ZllchwSvSWi6sGfJyttM9tD3aQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DSmWoMDGIU/Q443ndSPO6FosOOaBhrnk2bOVDHEBuxlJ7ecAT/+pFUmagjGls+mkw
         4bJ4+0UPYoIekKBtmP7DPGpVVD4JFFZ6wsuA2aSudHsJW7ol468HTnRk4DYkTxsw8l
         u7aneLhAtCe5Kqq2iH+MBQ9gdq9ydFqG6Lqd/tTDFQN9qFAkWUOAXiO9AzWArVed5g
         VMvhQzna/SWSv0jHjlWohvEvX1wVUFNVWQr4Mj1N3XEzE6kE4VX3LN9YmVxyu8bUjo
         QH3OryOCDSPMyKxQ8x9sP87kNDsJm0hT2b3ECBjoKVkgE3aYvRm5ZqJ0O9DCzCCYhN
         WHjEZwwn48tuw==
Message-ID: <740fe39c-dab5-4ec9-b717-f5168e689985@canonical.com>
Date:   Wed, 18 Oct 2023 13:34:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [apparmor] AppArmor kernel audit locks up system
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andreas Steinmetz <anstein99@googlemail.com>,
        apparmor@lists.ubuntu.com, audit@vger.kernel.org
References: <CAOTMNwuhq9Fc1PW4Y6ZOyP8H7nCk3+9gsxRapRuScZ2-a+14hA@mail.gmail.com>
 <668dd928-b00d-4f7a-5e6a-b6efc6a9c08f@canonical.com>
 <CAHC9VhSQ2U0jhW5Goa+OTTPtx64viGjFWFJy7Y7CsetOaWs6jg@mail.gmail.com>
 <CAOTMNwsca-CuzOdmc5HeUCtBGWJVKb2GB_r1QEF-TnJv1Kkhyg@mail.gmail.com>
 <CAHC9VhQNTiX=na2a1QsAQWwPfjuvd2xnFGHAPxTs=wQXNt6eZg@mail.gmail.com>
 <6da3d0b6-aaae-4586-bd71-749d6fb38708@canonical.com>
 <CAHC9VhToqz-hs8vuUhd=vNKOXNc_iXOAbtuVTNGWJUvbbzq_kQ@mail.gmail.com>
 <CAHC9VhQyb_SfA0_=fqrVLZjYj76gLzwnf2Gs3j73FRVD-0vGeg@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhQyb_SfA0_=fqrVLZjYj76gLzwnf2Gs3j73FRVD-0vGeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

thanks for the poke, I have been meaning to get back to this

On 10/18/23 13:03, Paul Moore wrote:
> On Mon, Oct 9, 2023 at 1:51 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Oct 9, 2023 at 1:41 PM John Johansen
>> <john.johansen@canonical.com> wrote:
>>> On 10/9/23 10:06, Paul Moore wrote:
>>>> I don't think anyone is objecting to resolving this, it's more a
>>>> matter of *how* we can resolve it.
>>>
>>> currently I am see four crazy/stupid paths forward, each with their own
>>> pain points.
> 
> ...
> 
>>> 4. caching a reference in the audit_context as paul has suggested.
>>
>> I don't like this idea, but I'm struggling to come up with something
>> less awful.  Below is a quick, untested patch to describe the concept
>> with code.  It is worth noting that we don't take a mm_struct
>> reference in the io_uring entry point because I'm not sure filtering
>> on the executable file makes much sense there given the async nature
>> of io_uring, however I'm open to comments here (as well as pretty much
>> everything else in this pseudo-patch).
> 
> Looking at this a bit more, I'm now wondering if there is a fifth
> option: call mmget() directly and skip the task_lock().
> 
> Take a look at the move_pages(2) code path:
> 
>   SYSCALL_DEFINE6(move_pages, ...)
>     -> kernel_move_pages(...)
>       -> find_mm_struct(...)
>         -> mmget(...)
> 
> In find_mm_struct(), if the task being manipulated is *not* the
> current task then get_task_mm() is called, which takes task_lock().
> However, if the task being manipulated *is* the current task then the
> task_lock() can be avoided and a direct call to get_mm() is used;
> get_mm() does a simple atomic_inc() without any additional locking.
> 
> What do you think of this approach (untested, copy-n-pasted patch):
> 
hrmmm, I like the idea but the task != current path still suffers from
the issue. If we can verify this case never happens great, otherwise
we either bail on that case or still need to come up with an
alternative.

otherwise it looks good

> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 65075f1e4ac8..ffd17ad97324 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -526,8 +526,19 @@ int audit_exe_compare(struct task_struct *tsk, struct audit
> _fsnotify_mark *mark)
>         struct file *exe_file;
>         unsigned long ino;
>         dev_t dev;
> +       struct mm_struct *mm;
> 
> -       exe_file = get_task_exe_file(tsk);
> +       /* almost always (always?) comparing @current, but handle both cases */
> +       if (likely(tsk == current)) {
> +               mmget(current->mm);
> +               mm = current->mm;
> +       } else {
> +               mm = get_task_mm(tsk);
> +               if (!mm)
> +                       return 0;
> +       }
> +       exe_file = get_mm_exe_file(mm);> +       mmput(mm);
>         if (!exe_file)
>                 return 0;
>         ino = file_inode(exe_file)->i_ino;
> 
> --
> paul-moore.com

