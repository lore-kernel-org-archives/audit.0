Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866760;
	b=NXsppmDEWau/qg2K+qZ91AajTlNY275oSTWpYhZ6axPnGY69ssW7atM8dfS7b8+z1txQ
	 FMvDKehFDisgzf7vra6tuWkL9V1unTjl45q+uwtK1eXrd//GM+T6vaJ132pyYBNj39J/O
	 4RBF6uvvy8JKVaDwZTL9e2R/Hzz2c8+Lf+vFckeWNj66Z/h38K03uhIXpqLlqOT6Ftfxu
	 mPCjyKB6qGmrGc7bcbMM2lEhcwviBwaUpF012ejcdOsY6F7doPofXCRqsXGHmZ+gm/CTx
	 N7lCF1kz2TEbMMY3FnynOCE1o4U1tPtY4qpcKdjN7E55Hd7RV/jOWyCRl0V8Eq6PWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Subject:References:In-Reply-To;
	bh=qv0a68RBuYoZCQg+3NqzOXVvq9jBL0InMI3OhomRJ9Y=;
	b=eUW+w7GnOn0BfwDYi6w2jgnNk9J4Ko9X47ogR/9Sz4MNuhIzHHyD0fFfZ2nztkmUCnm6
	 kC+EXHOOSg8zSPs/lOBUNSS729OENY0kS4a4tFK8vY/L2sleh9NbrnbgCSiAOYDskE4Tb
	 NkqyamtlRGrMqlgCbHrVllKgQgU8cVRa8hmf23bH88PkaiFQtZE1Sam/YDeTqYOnzAUzW
	 tbGLsq0A+QZu1tWfSXmb//x3PLMIW7LQEhEbB83y5hPcP4edob/V0jHRqIxr5wh+i/0G8
	 3nCYS6jy/ZiNI4dnnOTkcnPBaE+nnESLo+VPZx9jEE+9VzOSxtk9NiDMN0uqP8o8QHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FNc5HTLi;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AE606A31C
	for <audit@vger.kernel.org>; Mon, 16 Nov 2026 22:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 993AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=FNc5HTLi
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53634b8328eso41179161cf.0
        for <audit@vger.kernel.org>; Mon, 16 Nov 2026 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794866759; x=1795471559; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qv0a68RBuYoZCQg+3NqzOXVvq9jBL0InMI3OhomRJ9Y=;
        b=FNc5HTLiWaYRhuMbbLPQyNJM+qc6ItyE7h7+07cRpR+L41ZwHlODDobYrHD45qy0/O
         TABDl6NcrnzNNT8v/gLiBgi81K/E1ijc/5RfHmSkPGNLI9mBJxqzsreZJ1k8/bTuJnGX
         KL1m0U0ZyCYJXJrceDp6If4FvWEvnWX1abw65Yp/I0ow+8sVnx7d8Jt+F9EOHDzj5mWx
         4fVGOLVtiWmwYFa0RPBoZMkfvz0SatBr/4/7ZLCI8SsQIj4Kwzo2uZvDvKwH1CD/EXhk
         WVzD3H9TNmAHJfzUjbmEbxSYfOYmqg3RT7S9fXf6NIigdGVdIn0D+6PflLftWncz/koV
         Bu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866759; x=1795471559;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qv0a68RBuYoZCQg+3NqzOXVvq9jBL0InMI3OhomRJ9Y=;
        b=w4VPMEkjLYJEQjVOJaCTieJWXv9yvMLWIf7GOpkmPUz7Pg6lG9CQGqlwDBoMX/yDpy
         CJulTjrzPY+08Eq314t8UMkrMknD+lm3kCZcXDvMl5BxQj2i6A5ZWSRrcDS+lUEG0SpS
         iL0vPi4MnF7MHPIf712y91tR9aqTnom1ZEmxZk4SHUbFGaGcugmI8GtE+TNMa16FlIwz
         h0yt2uSPjg9dfL7o6w1Kmu4zVRzOteF3iGSCh5BfIxzfkZPoPVMkErCM8uJ1sjL9RWfC
         JnsLyEeIRkuUDOp9dSWg+p1nitO92V/Nslug759IQ29n7aI6EA2s4UGJ/D75P/GXFsKd
         c3iQ==
X-Forwarded-Encrypted: i=1; AL+hErFmNhlUocUG/jRNFqsOM0rMs8lxbhKxFRS0l5PVs/sIat4hbNabUpDM5wpIzl/U5Wd9Z81PvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+m4nzeyFnDKzqDX0j67oZ3nCBi3UYeIPo6ad+u+bkB9+t7U2Hc
	0NhVr3VmJyCLEwfvJIPkAOIAcJplzQmWMcFIA3pv0fspRHxa7cHIiYZ/YrC5GljSIg==
X-Gm-Gg: AYBFou2mtt2g58EOwIlHDfAQnNVo/ulKAbN3KVTS8IW3tVgvzaX6Kn8QLxGK7xmgBNU
	lsBQUmRAgdB3vC2mZbbNmxDAVMdsRPcyE9V9A2Vpxp5Mmk6sZzwYfvD5d/fWmZ02TjZrry8uGGo
	VhalbDtzft7HVrlolCYFgi2KVgoDk8JgfrEIUpiXH3ClzumyaqGsGeNPpKSaenGqUr0Pv/98QvI
	v1t/I0TDCoUbU8MY563270q1jWgBgC/w3pimiK/zksPu6xF32wG5nF+JOtN7ci4pLfhp+1bazfL
	jzJq5p1gqVEJIynTX6LCVK4MQySUNTBRmj0YEQ91qLzZzu7R967oUFlWtxkR7XNJweQJTbZ0xis
	9EsMh8GqMrPq976ZcjTrqhRZlOgwm/TfubVgH/LORGP35DoNwaP5MbDywoojUcFwcSadSZB5TZQ
	uOIcIVeesEmn+mS+OFYQ1+1tM+LAS+8GyFXNjRS1M7h5swb7LwiH+SJZphx6SKZgSmeqWrln+Qt
	FDl5r7FWVRJWiWjirXZoYwKkruiocYkCOw3kRm9NCSmeXiQyyzTCXrkgxfhdiys4qHAD5VvjyO6
	i1uo/LDQacw6qIey/TXA8Miu1M6L7nl3RuneqsCF6t3GP6SZxFb+8xSAm6EYzx9+Uh1xXr+muu1
	45AtB52ypVD/qFVh492vwc+9rLtoRwHhLlhz8Na926t0wJteUCk4=
X-Received: by 2002:a05:622a:4cc9:b0:55d:3648:a107 with SMTP id d75a77b69052e-55d3648a9f3mr78728171cf.38.1794866758635;
        Mon, 16 Nov 2026 14:05:58 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d6193esm95338196d6.19.2026.11.16.14.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:05:56 -0800 (PST)
Date: Mon, 16 Nov 2026 17:05:55 -0500
Message-ID: <02989c90126c8601ffd0e4ab797c7447@paul-moore.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261116_1350/pstg-lib:20261116_1227/pstg-pwork:20261116_1350
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 3/3] audit: retain file paths for descriptor PATH  records
References: <20261106150342.670199-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261106150342.670199-3-cgoettsche@seltendoof.de>

On Nov  6, 2026 sashiko-bot@kernel.org wrote:
> 
> fchown() and the other audit_file() callers collect inode metadata but
> emit name=(null), even though file->f_path is available.
> 
> Retain the path with balanced dentry and mount references, and use the
> existing audit_log_d_path() formatter when no filename was collected.
> Release the references on context cleanup. Descriptor entries carry no
> filename, so they can only be reused by a later lookup that matches the
> same inode; keep the retained path then instead of falling back to
> name=(null). Filesystem exclusions continue to skip entry creation.
> 
> The name reflects d_path() at event emission: concurrent renames and
> unlinks can affect it. Original lookup names retain precedence.
> 
> This adds sizeof(struct path) to each audit_names. With the preceding
> capability and layout changes, audit_context grows from 880 to 960 bytes
> on the tested x86_64 SELinux configuration and remains in the 1 KiB
> kmalloc class. Other LSM configurations can have different object sizes.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
> - reset fd_path after path_put() in audit_free_names()
> - keep fd_path when a later lookup reuses the entry for the same inode,
>   instead of dropping it in audit_copy_inode()
> - place fd_path ahead of name
> - use the entry returned by __audit_inode()
> ---
>  kernel/audit.h   |  1 +
>  kernel/auditsc.c | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)

Nice :)

Merged into audit/dev, thanks!

--
paul-moore.com
