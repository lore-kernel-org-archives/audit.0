Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204B630E0D8
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483582; cv=none; b=BDl8LRjBSzrXbox72zexkv0tnnz+jUNaJk3WQ9viFoXgJ25TXqGtXX0mHCk293rYUc/TEDQ11LTN4ETv4Vtjh4r7AyJt0/MnuZ4p/zuSFq+ctwDbVVBsFGmT9WyssPYnz2dfAaUhpQXKHosVFvDOHxutG0mRk9ss9l91w0Z0UUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483582; c=relaxed/simple;
	bh=2OjZR0xIzGES+vVHimuhr1zX3QGgjQKBqN8vzmD73Qs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=nwkjWAoBHG/bZYdeNYAzn/vIwoYt0O4XZzERMhT5A/hLgS8lQqxCRRQXjOKp4qMO7tjCW/6W0coqh3M2sBOdPWB9fu3d8km9XOl9qlyDhQFxRrJ5cEn/6uJGLKAA8YiSaQTT/SgmT1t3jrubGB8xfAAZkvHRe6tlLrvLhmMNnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WMyFQcnO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WMyFQcnO"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7960d69f14bso46052806d6.2
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483579; x=1761088379; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=WMyFQcnOAdB/+dSch4ZN4hT3y02F1Jxkg6407M2HSVC6sCpMjABchEszuEZXFkOjZv
         AcZMRdb3M0pJPorj69ymuxVr+f9TiowBWhxn428bmBRA8pxgRP5uCBWj2tHRmvgt0Yc5
         cls1grSuL3az3zgt/ouDRbQ088bZabq+Nn8wyJliCUpl4KpTpMG/8UnBDYE55dmOUac8
         GulLGa6WPgFfbLG3S66PPcuUwyu5RnSP5pHlg0W5nmQBrABhvVUGqJNYctvzFJTDS0Am
         QIOXzeeZdqujE6G/ixfdRe0VHk/aVeh6YtXTsvHix9+m7LLnBKyHjuY5Amr1KOfgQd5T
         zqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483579; x=1761088379;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=lpdximsJdeBlIQALc+TqBDVaJOckONo6YVq/BzChTU1XQfJ1dTyVAq4oDJeuw8ZQBb
         LeatyDx+grZwzYXTSNfAJWYkORQlNacL8Qi6u315cDNYa0fjIm4VmOgXarWzddiKsduP
         RR/QL0S9ko9kz0YDPskMWbPYRlIPoTYyNTeOxulQec+uLgm7Mlul55+crPzY/9bmdUGa
         FBbzzkN6XA7CXbvQiViZVCBiO1VCDqUZYZMjVeNxtEUUHU4bGSkncl+hvnlbaSg3JEds
         ELHmUnta7YXi7BtH+XJ8zldlrXr3C1PAErMyrs89Q/Xu6bHj0dDV8guf2oqNOCyH9GJd
         N2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCW3fqkEbK13+Vn2B/+2afn0Q3JDBe8VjyEUlpEbYGfULTc5vRTrZl4RHpBKRtIHD6PiakiqQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80u1CvNVD7DqbqLwHdrU1rqKlGwvMOqPMY/C7EZps7dpuK+fr
	cKLPU0HL1Ct6Zr2eUFAqRLksiBYcE024EXD9e+xI+mC1mNO6bKNvSb16lFB/dFLIDQ==
X-Gm-Gg: ASbGncvYuZ62+Fmd+WBOHtRtYUXNk9P+AanIURpXH9NHzpb1/IXP+mKAGNNMf4OJP5W
	I7R8LfnqWW3CiHaGr1MAEgH80vFfN+UeVoboGAS7GiAvJ7d2njtcsGDLRf5RWmyGqfOyrV3VuF/
	iXH2eHlOsWzKpM0W/dxTsqCrfYKE6j9jGdz/myjR1OFDRhq0ioqTDER30Gff7RbeVj2zw123KfF
	krlJJJq+hiE5IjOyk/HLM25PJnnVR2ScpkKE4MQjhoZPipInd/3LR96wo80z/eBsfGOChyDwsA3
	p9ksQrSNH5VH4en/zUolPqhWV+Hy3l/HI4bMf5ODYoD+/5LUt2lvVAdek3OypDijYm39nqyIshg
	pkCTM7PK512RHcoM0plGOa6UIHhQflpSK0TKWnI4RVq3f1pqhKCm4peMT/X3C5M6NMb4K5TksiB
	QsM2wgySvl2gJZSvHydelNYA==
X-Google-Smtp-Source: AGHT+IEptTo2pxg8BQyRH/EAXGF7Ajlrs/OC3K7xB2VEK00ORspclexLASyXzj0clJy3+lke8DpgeA==
X-Received: by 2002:a05:622a:4814:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4e6ead57ffcmr362320031cf.50.1760483578960;
        Tue, 14 Oct 2025 16:12:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e885f1bf3dsm517031cf.24.2025.10.14.16.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:57 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:57 -0400
Message-ID: <3559abfc0d5ceb11f03451aab517c8d2@paul-moore.com>
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
Subject: Re: [PATCH RFC 11/15] LSM: Infrastructure management of the mnt_opts  security blob
References: <20250621171851.5869-12-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-12-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the mnt_opts->security blob out of the
> individual security modules and into the security
> infrastructure. Blobs are still allocated within the modules
> as they are only required when mount options are present.
> The modules tell the infrastructure how much space is required,
> and the space is allocated if needed. Modules can no longer
> count on the presence of a blob implying that mount options
> specific to that module are present, so flags are added
> to the module specific blobs to indicate that this module
> has options.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c        | 14 ++++-----
>  security/selinux/hooks.c   | 58 +++++++++++++++++++++++-------------
>  security/smack/smack_lsm.c | 61 ++++++++++++++++++++++++++------------
>  3 files changed, 85 insertions(+), 48 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com
