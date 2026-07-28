Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4042E0914
	for <audit@vger.kernel.org>; Tue, 28 Jul 2026 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268430; cv=none; b=i8LvujjFgL/T+o9c4beuL/HVC9h6v9AlKEplom7cVOUJf/+fKvCqTni+QX8Yk8H11c5JTej/qOPn6DSI+2FcPIFX0BOeMA5e6jlJUeZZH7QWnKpiftgrgjuQrcIOI4ArHZt1BknWY1Umk2GY0gOZXAOg0VWSZlaAcIosMgwD/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268430; c=relaxed/simple;
	bh=Zo7yHfsmbbnTOgBbDPPT7iJ1LJDbKs5DhVu3bUUQDF8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MFwxrFenCYe1jRgpb082q8+a+/PQYq53MDrqv0PcTSJHqc3I2H4vdM0F0ERCv4VoeMpNipLZF7/NXJTSbrEMwEZldZ3mlLbBlH9hunxReKRSZLPLrIjMYVWuqdp/xvR4+aXp2yxPw8VQFhlvL4kFIAjS0rILQ6QvGjHKBIDy+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VFhYA3t7; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VFhYA3t7"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c21495722so1105551cf.3
        for <audit@vger.kernel.org>; Tue, 28 Jul 2026 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785268428; x=1785873228; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHrIhaQi9DJt3hZXGupitmaEmqcs9r2Pk6D5IXCY+/g=;
        b=VFhYA3t7ng23cclYE0ymAASjD2zZ9+jI5W8poQbp5cQwoI0Y/fKhlgiz0/XqgTpftr
         4uk4L1cJq+T9ZrGR2dor9rGx2R+IOTAOOjnVwe5Ktp7+9Sw5XmhjMNwXwI7Cysx7OH9X
         c6/PyDNcAjmWsXP1Oe9gmZWDWo4P92Gqjc6Xi2cVzKIPO6Jabz95GXpUVUAOg1tyGjbJ
         uRgh2TScyNOmfXHhBHrP68OOby6TUMmOC6zn4PUZGRkfIs81icb4GDrPEeNmyocWCr0j
         IZ7Drq12y+3DYpI+2yhwD1enxy/7u/Q107PUCYz18ceQitvHc1qwD3ixwDiTNstew8DZ
         8mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268428; x=1785873228;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHrIhaQi9DJt3hZXGupitmaEmqcs9r2Pk6D5IXCY+/g=;
        b=B/N2GqmgwOg+LFxyU5SUJAygs5wIv3mmbVRPXmtuHKqD1VkYtIRPdR11EUD6buVq2V
         dO9QD1v/+Fb4d/xURRjHBmd8FeZvsB8BfJIn4YGIsi3KmtP0OQ0OQ3FQh39nyrlhIeUz
         9rMncllJrC6YenReYuHn+GN6J8D36LIYkf53tGPAN1UedD8dZyWreCd/iTspvJuwIxlR
         R+Fw7qdUkjd2CFPbmNtUAzWvaq4DC8xQdcQSKzdN3ZkFZdcvZTrFulyuzMMvcjwy2mGE
         r+LBudgDiiWjMPnef6hbPf19M/qM3T0gPNhKsQcEwVIhyAv7oTQZxKJKBrt9SSowsaDg
         IJFA==
X-Forwarded-Encrypted: i=1; AHgh+RpO1IUzu5BCf0Xvsxi8z+6lQwzJbOXATgIy8mGFEr3+nlcy2KLznj5aQZYtaKcLCkUITOhw0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiDolltRSnAAh6SSHQJckNUbxfhnoi7gzRxpYGAu4Xum1al9Y
	wPwOF1AOcDnfDulznLt9f79pmyuE1lQYMk3y1QoCBqMsfASTndNdWOYBhXhTDcEONA==
X-Gm-Gg: AR+sD11VrlAR/GWLmlbPXDQ4DNedoqnUHW1MWFJbycUFJkBAvdrGLAq3nSVedWMbaTh
	BapimAgkgVYEkS44jOBI6vpI4y1il15u97uqP3JnTpQdywqUfedwnoOrmlzmegO7sLKHEs+lCBH
	uWbtVPDP+X22l3WoN5vZ5z66daYgD8QPM5xY6L+wug6jnmWgTmd7t4Fgd5P63lNDYTBDTyBkRYo
	+4uN092aC8OtFrLNsUhqS4RhuUf2ysMXSQaDLzyjhiHynjPkmwJGwEWuQ3UYlYIbLXZ/AYWS5oq
	/3Zn1sKMpzGRBA8WW3K62cMjnMeUzEoYTsik35VTPpFbM8U2K/oNDl6JjVlERNT+16ZAhdwNG9j
	aUyw7tozZnHQAzgYMApWdKDDj3g+sPuWpWUzp1DJvwB6/vOO8LwWei4cfPeK9fiag8oJJlBaycT
	g++eTO2cvrd+o7pmC85TgIgL4PgeSM9bXY83RSrOnCcWh8tS05zDZuiQLhe6Vg9ZZ8erwVgD5td
	JAPWyqttbCW3M41L82izk8XnLy/2qKGdw==
X-Received: by 2002:a05:622a:145:b0:527:43a:2f30 with SMTP id d75a77b69052e-529d6faf67cmr36749651cf.1.1785268428368;
        Tue, 28 Jul 2026 12:53:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2dd3d59sm4752421cf.21.2026.07.28.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:53:47 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:53:46 -0400
Message-ID: <883ee05917e857f5176178f2f14f3cee@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260727_1648/pstg-lib:20260728_1147/pstg-pwork:20260727_1648
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH 2/2] audit: drop BUG_ON() from audit_signal_info_syscall()
References: <32c8fbc6f680e8309f64fd04f580b6a51bec0176.1785246707.git.rrobaina@redhat.com>
In-Reply-To: <32c8fbc6f680e8309f64fd04f580b6a51bec0176.1785246707.git.rrobaina@redhat.com>

On Jul 28, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> The BUG_ON(axp->pid_count >= AUDIT_AUX_PIDS) check in
> audit_signal_info_syscall() will panic the kernel if the signal target
> pid array overflows, which is too severe for this situation.
> 
> Replace it with a WARN_ON_ONCE() and return of -EINVAL, instead.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..2b9ce0b52511 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2712,7 +2712,8 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		axp->d.next = ctx->aux_pids;
>  		ctx->aux_pids = (void *)axp;
>  	}
> -	BUG_ON(axp->pid_count >= AUDIT_AUX_PIDS);
> +	if (WARN_ON_ONCE(axp->pid_count >= AUDIT_AUX_PIDS))
> +		return -EINVAL;

Part of me wonders if the WARN_ON_ONCE() should be a pr_err(), possibly
ratelimited, but given that I don't recall ever seeing this BUG_ON()
trigger I think this is fine.  We can always change the WARN_ON_ONCE()
later if needed, getting rid of the BUG_ON() is the big win.

Merged into audit/dev, thanks.

>  	axp->target_pid[axp->pid_count] = task_tgid_nr(t);
>  	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
> -- 
> 2.53.0

--
paul-moore.com
