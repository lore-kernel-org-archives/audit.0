Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B4412BF8
	for <audit@vger.kernel.org>; Fri, 24 Jul 2026 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927440; cv=none; b=DGuBR1zDwP7CfTTV2LFk8gA5o+NT1N6csGEV3fmEFHFHaVGZikeE/wKtYOxqkPJl3lGUL1VVxPWxkQ+CLhTChALMbsqah2rr3RqLtiK3Ykq7Pt0NFaGOswIqhz9j7Z768crze+DvATzlWeTF7fivulP33YXx0qd006fDEg+PqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927440; c=relaxed/simple;
	bh=uJykGS3QzQ4tvxZjLWHg5877iVJ4SfE3tavrwKMgWvY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RAKzOXNrOaPdB4kyQDBmsFQn9MLxMUW65ImcLjZRM2qXTJ+2w31OM4w3GdITxUkqInBqbF/YNL23AuWMF9jTWVJeset0fBRyhKqjAKfOo72FNaluk0/BoVan7y2IjaWhfmXDV1n/6CK11r+3ma7ufIBqNl5D3C0eFSIV5bzPXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XY9F4k4v; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XY9F4k4v"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9061a795d76so9000336d6.3
        for <audit@vger.kernel.org>; Fri, 24 Jul 2026 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784927437; x=1785532237; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yHq87L9vS3HaE9jFDV8bI4q/vxtGKRIuk5rLrUpJx2M=;
        b=XY9F4k4v1mK16fiOg3tFiRVBKhDyczLVSXM5P8e7GhrLs2Ym3ZYtZIlQlUwVbFOex2
         w/rD4ksL4FdN45QllnvZlpzNw064gQcbIFs8RWCRI+p+W5ofwIde95TStccIOJktC7Bj
         LR1YO4Y8H7Gv8+zQA8mwp5joYwmGupwxOQqdJ8p5GvP1nOUTo1Zn2s75MNsCeUdxUUPo
         t/Y4+Iw1uuU5lJ/lAKV9brLaNi9TFo9v9x6ryXzciiCvscD5uCMeGU93MpDz1vYhqaF4
         KyNhLJIb74wRu+vCXyT8ro6BICX7RVMT32l32nSYtPWdxwQB8IfFYX0ufF62mYWhiAlC
         iYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927437; x=1785532237;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHq87L9vS3HaE9jFDV8bI4q/vxtGKRIuk5rLrUpJx2M=;
        b=mUZL0oG/Nfojr+5O2Z9wnYZ8hg+cvJsGeMmGH42rUaX8LCOSTMcXyr9Hlah4vID9BQ
         FHw5h3i2mUZxc6jwcAu0bw7vcNlqU5+uwG3iyTPiucayJe/xSSl1eIpS8+3VVPUAPLRs
         2z0gUWsduQpuU7p1YQ9OaaoDK5bqjhMq5WXrhWhewhhIbuYx0pHVDsVCQR6WPrR4cVaV
         UL+TG815E6tDENynEKnFHNLgKo2A+6v+k0HgRLf88Is4bBfkhJE+ktvsxrl2XUW0Cln5
         xFgj+TqL43MrP2Zq0vTzRgD/qlWs06WJMySJE7MUNmAdByrp9zEkz6HIhBR5Vjm0A8SH
         O7Eg==
X-Forwarded-Encrypted: i=1; AHgh+Rqwj9f282r83wAQNXPrT8cjqBEJ7AqYh5s277WkZNZnhfcmfqYc8eKUsI1RvqGWun1NFQW8Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPe3JGuCVR+3hd3RvO4liyxJIoisJSXohYXMzdr7vA+3EOso1x
	D7WwbOn01KVWvbehWTYPEBqljvPc0A0Y1Yyj9DzW24n2U/IOGiVJNor/GyMortsZdQ==
X-Gm-Gg: AR+sD11SPGFXNyHCYOFAAxJ86ObiuzALTtkxCBsgU82CeaaNaYLzcMpb554FB+AZ2/4
	MdurMsGGegsi2W6mIDN5UmGVc9tej9v9ZzadQANEuZpRZz8pj0u2937iQvwU+7d9gQSYPr45C3+
	pMd27/HKmowCMoawpLqXjY9353XmLpuY3TtWYh9yPdC4XQ5KeO7lds7C7c0r66+CebEx6PLA5b/
	LFNI2TP9tLxpXSnVgnQzPxlUa8h7IN+8SfVFKNFPGHpFbpc2V+1dU2LiJpPiFmL53GKgjH/GZG9
	97kAWidSPcLvdvYML/elg5odRbvsTJRs95GCBKd7jpXDabVzsPQ1ESvPhswt8PZakXwlCnRWy5W
	DkwJvs3uQXdegvfBUO/pBK/KeWny2iLLJM4xknzTQaWlQge7jjmBPvybpgFOOvD1JLQnc0ov3Xi
	37ibLY1XntfZhBNaYg8hXhXW9vOelFKG100ZkPE33Boi55w2aHTrtul1cF/w==
X-Received: by 2002:a05:620a:294e:b0:92e:c28c:9dff with SMTP id af79cd13be357-93103806f5fmr933223085a.6.1784927436759;
        Fri, 24 Jul 2026 14:10:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d499dsm6519536d6.42.2026.07.24.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:10:35 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:10:34 -0400
Message-ID: <0194430e27db3bcdffcf95b5dbf4891c@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260724_1628/pstg-lib:20260724_1535/pstg-pwork:20260724_1628
From: Paul Moore <paul@paul-moore.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 1/3] vfs: move create error && negative dentry case in  lookup_open() up
References: <20260710164233.827744-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260710164233.827744-2-jkoolstra@xs4all.nl>

On Jul 10, 2026 Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> 
> O_CREAT is stripped when create_error is set in lookup_open(), so when
> lookup does not return an inode, the case
> 
> 	if (!dentry->d_inode && (open_flag & O_CREAT))
> 
> is always skipped. We can get rid of this cognitive step by handling the
> error case first.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
