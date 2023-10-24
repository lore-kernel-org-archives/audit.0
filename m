Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7543B29F
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rQMtYEmY"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1693
	for <audit@vger.kernel.org>; Tue, 24 Oct 2023 09:47:43 -0700 (PDT)
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 101003FBA6;
	Tue, 24 Oct 2023 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1698166057;
	bh=Tp8oDK94jeS8bUNM8+vRTzMfyuSZFGHSiLAlG6TsMfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rQMtYEmY3Q7Kj/LcKfCEXWWuzbBZnh46jtoxcjxhcVBXeEGL8Kw2YihPoShqv0GAz
	 QKwmZosL6FhXejr2zQFpL5rVeC1fO0IlW3dEf5L8vsoZzj5iL5QT54G8xHENPMTBUT
	 6cHvb2D/TU1fyJAu3OIycLva7WxamCaTY7DxtcKwsW3wc1gAV+2uZ/JLYr/o1hwPd/
	 Wsdecnqca5FWQy3KeSEOXiG4Ef+6q2TJD+ZzZhofKPPk/J4ton5lKAr5YpA6tXgl5E
	 p4u+qBLTINX+qEK+LSoaL3r6bd4/upSha6RqG9LUxtS3mD7qJ4ixyB25CdZMJNgpHm
	 FXABLe+H71xnQ==
Message-ID: <a5650045-164f-4bff-b688-ddbc66dc95c4@canonical.com>
Date: Tue, 24 Oct 2023 09:47:32 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: don't take task_lock() in audit_exe_compare()
 code path
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org
Cc: Andreas Steinmetz <anstein99@googlemail.com>,
 Mateusz Guzik <mjguzik@gmail.com>
References: <20231024161432.97029-2-paul@paul-moore.com>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20231024161432.97029-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/23 09:14, Paul Moore wrote:
> The get_task_exe_file() function locks the given task with task_lock()
> which when used inside audit_exe_compare() can cause deadlocks on
> systems that generate audit records when the task_lock() is held. We
> resolve this problem with two changes: ignoring those cases where the
> task being audited is not the current task, and changing our approach
> to obtaining the executable file struct to not require task_lock().
> 
> With the intent of the audit exe filter being to filter on audit events
> generated by processes started by the specified executable, it makes
> sense that we would only want to use the exe filter on audit records
> associated with the currently executing process, e.g. @current.  If
> we are asked to filter records using a non-@current task_struct we can
> safely ignore the exe filter without negatively impacting the admin's
> expectations for the exe filter.
> 
> Knowing that we only have to worry about filtering the currently
> executing task in audit_exe_compare() we can do away with the
> task_lock() and call get_mm_exe_file() with @current->mm directly.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare")
> Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

looks good to me
Reviewed-by: John Johansen <john.johanse@canonical.com>

> ---
> - v2
> * dropped mmget()/mmput()
> 
> - v1
> * initial revision
> ---
>   kernel/audit_watch.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index 65075f1e4ac8..99da4ee8e597 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -527,11 +527,16 @@ int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
>   	unsigned long ino;
>   	dev_t dev;
>   
> -	exe_file = get_task_exe_file(tsk);
> +	/* only do exe filtering if we are recording @current events/records */
> +	if (tsk != current)
> +		return 0;
> +
> +	exe_file = get_mm_exe_file(current->mm);
>   	if (!exe_file)
>   		return 0;
>   	ino = file_inode(exe_file)->i_ino;
>   	dev = file_inode(exe_file)->i_sb->s_dev;
>   	fput(exe_file);
> +
>   	return audit_mark_compare(mark, ino, dev);
>   }

