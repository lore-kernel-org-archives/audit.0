Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71271AC8AD
	for <audit@vger.kernel.org>; Wed, 28 Aug 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878111; cv=none; b=lGT1jVN+GQrTtH0G0HubqV6BF/oLOklrVSv2rV9pv9QlA45pstsOiwBUWcuMgwRm1lGOoNOSMTX5WD6cpk4Dv+AKyLHoko6mtfk8vSB0H/mowzkErvBdQlsFzFpRuPdeA4ZREuFDaE4K2ZZhQBa//Hvyw3hvbtNLrUJlPhPQrk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878111; c=relaxed/simple;
	bh=gJaEHXrTeNSaE4eFCVkHF+bcWMfkiaVOpQZnIb9GD4U=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=bcJV0r8xEXhlRtjS+expDO7aQzAV8ur/sksFehmEPOBRtu1lPXeZ5EovO37beTpgapdhAXI6PVYnWGU3B/uegsRHwUVFil/L93Tw6q+BEwUQXXwkYMV2VWrimImSDkG5+vO4uZjNZiqgblxDQkSGEbHHSjI8rfFR28AhHxHlE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GlWXGPnB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GlWXGPnB"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a7f8b0b7d0so49878685a.2
        for <audit@vger.kernel.org>; Wed, 28 Aug 2024 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724878108; x=1725482908; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFm1oliNMku3718rpHjj5GFBtdpffkYvzVOrkmijuG0=;
        b=GlWXGPnBBJwQNRZ8oLVwjXsh7T5iM2cG9JlXwHU1itcKLBeDEMbJi3T4tg/IXcNM3x
         gGBFE7P6UB+joqEbiY9rKvE42MLeC/zou62AZS+f2L87xCvcvy7KO+o7TrYGo7f8/vPo
         +lUMlgSNm7h/wdm5TmocX3Y0HJuLo2XMQrwErHNcApFyooGIceUNGmQ0ALSBK2Krok18
         SSaCDxpLyFo9ds3kIcCZhR++WxgSDig6cFOuGUUELIhDpsEDnJXk7tXa5oUSQkYNVtMi
         ILFYNhy0qCkpFUUOU6MIUCdqJJI2iKS0BrTEdewXbdULdSfaaWnQMD7Mhx8UlIJPMb3P
         BgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878108; x=1725482908;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFm1oliNMku3718rpHjj5GFBtdpffkYvzVOrkmijuG0=;
        b=j8NA6NHI+X/4Bl2zDIYfkMPB+n/HpR3gfTFm5nf7m1heBhnE8KW9vv1OqfmEOqd1Ug
         PgGaYycmTY7FJKmyH/ZHg/bjB3pApkk7aX3INb8mEFdP/BM+TRHXYItbk2dlo9ZdXFbF
         fjyoK589G278DqSTvj0MYSR+pulk1YtlvGMB7jW6XK48EV2ObV0qJqhSdflcZh2/qski
         3OJqhy0lldbNdhmLWZ5ClTpofkcLj8ZYN1cIVytingda4oxoZo5BAeL5cJmq6CNfZyM0
         8vjZQHD9zu0qMjv2B+XMRE0Q5X4yjqRHjxwIv4x8NfunJ3R+jN6gUc2/psVQhPneIPG2
         fNgA==
X-Forwarded-Encrypted: i=1; AJvYcCW7H9ixo3X0wvefq947t3UPgDLExTX9uI5vWVn8UVyk0Y3+6wh0xhTDURIgp/3PsiBNqJ3dYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN15/El3OtwvjvKGWJZ5t/oLCiPn3L69WgvpSP+w3wTADWfHo2
	eNcv+RB9ZKncy7zlN66KZ1kHhAOpVAVvgV1+++2lhY7TuP1aX3UBwbjRPVTJZQ==
X-Google-Smtp-Source: AGHT+IHAdwjDarEQRu2k18EI8XasHntWYP53AaFrsz5sI5yRSFmJR7fmGFZ2aT0hMkzM5kEv5sHRug==
X-Received: by 2002:a05:620a:1a98:b0:79d:7d6e:e02b with SMTP id af79cd13be357-7a804267f40mr64537685a.70.1724878107666;
        Wed, 28 Aug 2024 13:48:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a80236a344sm35923085a.81.2024.08.28.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:48:27 -0700 (PDT)
Date: Wed, 28 Aug 2024 16:48:26 -0400
Message-ID: <49419bd051ccdb64de7222e2d17aa77d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>, eparis@redhat.com, rgb@redhat.com
Subject: Re: [PATCH v2] audit: use task_tgid_nr() instead of task_pid_nr()
References: <20240828112528.954163-1-rrobaina@redhat.com>
In-Reply-To: <20240828112528.954163-1-rrobaina@redhat.com>

On Aug 28, 2024 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> In a few audit records, PIDs were being recorded with task_pid_nr()
> instead of task_tgid_nr().
> 
> $ grep "task_pid_nr" kernel/audit*.c
> audit.c:       task_pid_nr(current),
> auditfilter.c: pid = task_pid_nr(current);
> auditsc.c:     audit_log_format(ab, " pid=%u", task_pid_nr(current));
> 
> For single-thread applications, the process id (pid) and the thread
> group id (tgid) are the same. However, on multi-thread applications,
> task_pid_nr() returns the current thread id (user-space's TID), while
> task_tgid_nr() returns the main thread id (user-space's PID). Since
> the users are more interested in the process id (pid), rather than the
> thread id (tid), this patch converts these callers to the correct method.
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/126
> 
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
> V1 -> V2: Added a more detailed commit description
> 
>  kernel/audit.c       | 2 +-
>  kernel/auditfilter.c | 2 +-
>  kernel/auditsc.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Looks good to me, merged into audit/dev, thanks!

--
paul-moore.com
