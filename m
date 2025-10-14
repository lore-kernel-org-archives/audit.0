Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C930F553
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483587; cv=none; b=sGyu2axpkeBSC19ORQTyMN1zchoUUk66MOI+woE2yVOH4ebEdV5KgkhUUZxGMxGat5CKrZUDnmka/285OJVBLfpS8nvKHKtW/gNUaNDKGCzVecXmwQGhDCl0SoYqmoLd+pYjrk6P2+Qxrz0fkOcImQaIdg6Skgqs8ZahrqtqsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483587; c=relaxed/simple;
	bh=QprGc4fiwHa2sVunw/L0P7g7jj+8/eCfXo++KOzEjFw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ntv9BCiiDsqIABIBDJd0OCTcL+YR3HDNiNXVMf4NsuWyEfo8fZTjkv2HbIrMXPyfLprIqrLr4aMIMjtk9MYJQyQhTYj3kqdiSqz11DhSR+IeUjwgIEDjIbCMUog4YWsbfMtCiLcHiuzpsiEuJwHj/rNYMxKqAGXZWmKXQnisPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VObL33kd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VObL33kd"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87be45cba29so45064976d6.2
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483583; x=1761088383; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCW09LQMgNqzUYKFVauSk4HK5abMbyRb6NkfqMu8LB4=;
        b=VObL33kdBRcegxC5zg5IwEsSUT3HP2fPT2B5SZANu6tODJvYc+EBeHHUm7U95ZC6g1
         OII0LORH3orDJnFNE3wVOpgtOKUtY6ubMu9sCmaeLv1mWUDZeCmieQ11x2MEjRmALOeO
         08ADMMxBOtlahaB7uP8080ni4Pki6+Afutmvf2uBWIT+GTYTf5p7MN+60cOKR9+ajeBQ
         vGOO3g6cOPws8EKtMj7aHzcoexLT3f1NTQzOtv1kP/jlwkZgxpINjsewOuABeE5TV1pD
         dL44d3Udc7MKFImerbo2XdhwfEEEqGUJdPolOHKRj+kod8vQZESkBJOJZe595pJpOTp4
         h8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483583; x=1761088383;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCW09LQMgNqzUYKFVauSk4HK5abMbyRb6NkfqMu8LB4=;
        b=kv5NVRgkDdgoMxR1V1blxKxF9njDFwXMKevEiq7N/gBI4+PzRXgQfNo+L1Wl+1GX3t
         /c5/CP/jNga6w69qiBI1XoumYkOJx6VfwI6gvw/5+AYXfGXPSmW7s+bD7yPaZFqma0w0
         yiTvH6NcpHGfLAcRtkhCbbo1nI9BW5iVscyYSEZ6PyeqnR8UaXELucU0AR1tWcuqezR7
         OWjPquFfZX7kT15b0KEOJHM11xdrgbYZbqBGQe4dyj0M7ItdMsTjumiYlZpxxzQ4w5vM
         JHcb6WT7UHHInrLGZx5WMwH1/mdraFTV+ZVqm5FSgqwsQBUY5PLiYILD2kDZJ/wuQCbS
         jaOA==
X-Forwarded-Encrypted: i=1; AJvYcCVxf/LwSTS58RfXAc/YZEe+E29vBvFw7eX7d46BTLl9aK7+I8/mzuTRL33tYY7X+tohgcG8Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHU0BEAR3KS/M3cIoYdSKMjK7nueh6YiQCe332UHrzsX8c7UE
	2jEeWqj0uXGW5TIUPSVKmeWC2PNgPKG4J+9bCMOnbwx9obMBmR4dOfdX8EWLyn9S4Q==
X-Gm-Gg: ASbGncsEnRqp6fFpxByvcPpWTKY5NN6Dj7fqPV1mKukn/QuG577Z+lCrYJbMwOJMau9
	wmOGH2c+5DAhnUYTA3LLXc7hiFu/3tdnVCLgnOXCY7L/qRccGT8+dckqF79auf1jHvCivX9XSyR
	7817HsKzei00PedYCYvH0YFUUjg8J2W5XHlWSSpTtJkTEd+jd7ICNu6z25mLp1tyNBJJL3SJgoY
	tmqODlytjZ88CliSSmrYs9eNeicAeaeGNvpS2WgGfkHPnoQpKcuZ0iDLKJLuZDrJ6e0x88piKs8
	GMajqsdQDkFNn/w40JZQvMYS+eINk/WPa0jvljKlH+4BitKJPk99OiW+oRsQIM9zCZ9m5L3a6Ak
	PN6rTCctwEJxpJ4p/40uem4AxK6hqMZmZW2E3mDsQ/4SH1PtQxgdiZWcRTf8iuAarhADLOvvEGI
	1/Niw83ydBmXQ=
X-Google-Smtp-Source: AGHT+IF0vEhjdhHpWJF1o9JDZ1M/kFsunpPIr6Pvii9L9sJVyjdFhsPC87oa0AUhanzmNTmFesh0MQ==
X-Received: by 2002:ac8:5902:0:b0:4b7:aa00:1e6d with SMTP id d75a77b69052e-4e6ead74a71mr387673051cf.76.1760483583382;
        Tue, 14 Oct 2025 16:13:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a1cb1sm6847536d6.45.2025.10.14.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:13:01 -0400
Message-ID: <9ebb0de0d0a7b889b70e083a99c59d13@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 13/15] LSM: restrict security_cred_getsecid() to a  single LSM
References: <20250621171851.5869-14-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-14-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The LSM hook security_cred_getsecid() provides a single secid
> that is only used by the binder driver. Provide the first value
> available, and abandon any other hooks.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index dd167a872248..409b1cb10d35 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2740,8 +2740,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
>   */
>  void security_cred_getsecid(const struct cred *c, u32 *secid)
>  {
> +	struct lsm_static_call *scall;
> +
>  	*secid = 0;
> -	call_void_hook(cred_getsecid, c, secid);
> +	lsm_for_each_hook(scall, cred_getsecid) {
> +		scall->hl->hook.cred_getsecid(c, secid);
> +		break;
> +	}
>  }
>  EXPORT_SYMBOL(security_cred_getsecid);

Another case of "would this be painful to do at registration time?"

--
paul-moore.com
