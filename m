Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7C2F25EA
	for <audit@vger.kernel.org>; Tue, 14 Oct 2025 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483571; cv=none; b=cdcWonqq5JtUioLVrf3M6/t3Xy5ffNOm3cHMSJdmzsxLim3SgTreLBVp2lvsOWNzH84SZwEPYbw/uV7KeyOLHGKwuv2xMSzUBxEdRmXOFWexfcyZ1mpboNiCpNl0U0BfR4o32aX0kLHrQw9dSp229lZq/OlFSV8PUcp8nrqAn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483571; c=relaxed/simple;
	bh=J/lt9znTcOVX1C2K1cX/09AgRB2MqorJsb2CpdVdu58=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=dLQb779XRO4riZ2jPRtnSXC1k5jhOwTn1HlqBhEti9xWuG6Ebm0DoQZInKmRfAWmiR1g1uWZHd8MBGSyjSecIeaprnGMpbJB8PoqBI0EV8kDcK9cQYwSlwK5c34S5eBrqNnp+IzVj0xcBNxavxOZ3cWzPt/SipPbND7jrcR11uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AcD2fVu+; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AcD2fVu+"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7957e2f6ba8so78457956d6.3
        for <audit@vger.kernel.org>; Tue, 14 Oct 2025 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483566; x=1761088366; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lz2MY9zidMtTyFezWf8KFBAdWsU3BX0dvEoC2e5nDVQ=;
        b=AcD2fVu+WecTG3dhWYaMZL6Ai9q5zS257/aPCYelrxBzLy4VM8JO2SSuVM/XkwnOg9
         KHHjLTHCnvWLYGoIBlnXCQRtp+ZyGIYxXAZ0wIR4yzkFkXa5P74Py3mUNvI6VGAnOW43
         RUibo1UL1IEvCxJOYur0c0N25O4LkpATHXq7idYu4r/Rf4ILiTTzF3zU4FoWUmQ5F1xV
         4++TilZ+VTylkkJp5NueZTZOz0Bi++t2+Iqe3hgAroBWg8SUqSIhYniC+YU8Fw4JccuO
         LCQFaHurXF5U2k3EfGfpS6HwYyWpvwnac+qlDinanUwWUrV8UhY+MXOG7pHUUW5G3i/x
         bYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483566; x=1761088366;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lz2MY9zidMtTyFezWf8KFBAdWsU3BX0dvEoC2e5nDVQ=;
        b=QQezRwzbiMv+SQ5wa6hkJH9n1pbCqDT3pND6Avq2D5XizEOeVV0lWRhbKty+liIWny
         YPWLefFsjyx55F/M44HF+FnGcHoNFK6iINrdpp+vOSwp0vIOVHUfx6uqaokayjwF53n8
         Kpy+OKaPFd5PY/zhNVxYLQOi/Pc9AAgX+zIcju8CFBO859gKfgHfTusQXVTmwrVAOWWw
         VInRmkuOeMyH3Wo5emXb090LuhCP3H4I3QR3IyBV1hx4B8bPNhiZQPc+kKTvVSVgkOI2
         pUayMuYohL08j37jaXMhJApJe4Fl7gEWBxjAooiBfjMwkr4LzReCBKqHo8XmikD8MROn
         zc6w==
X-Forwarded-Encrypted: i=1; AJvYcCXVFTwXGWvpJ+786MvJKolaEgQhMrnq0jdyj+jMH8WQ4lV++ybvYB8NL8zG9P/Ba0keH/yszA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnBbERbiQNnizRXp7IU19iyE7c7hrLRyJQsxpCSdei3eOxfnR
	gN5TbMovjJJ1Rwjq8QQXe2AxLHk1iiqJjOakEB/Y4xCnWquWYGbSvC0LKuFsrFHHXQ==
X-Gm-Gg: ASbGncvgy0hPHP2Q4sszzbVuN6AnBOjLrO3Uh304M08y0z3T8UgwQG/3ALuKYLEb9Ka
	u3TyYypjjVg+gIIZPAO3QA86QUKzeFvbeIdOgirv+3i1A3lOazgFLnZ/mmdM8lNPqQd0e44anSL
	YXsamrptQRopRH7daCxqwGbAQN2c9o/q1FvkGQrsN1ItoeZ6yjmDW7EZ+Ai21LmxqNNbmZooCde
	s5CxPA4leTtUu4raQxMh1lC29RTYqzQzQe/LGLu60L2D6lTWm/yk3BwaAdGrm7IGirR47KPoB1L
	FlCc6lRFo9xLhIB5oFNNH8tEaqATPAVnwk6rYMo81Bls4rlAitqmwuS18V1Tak5mPGU/ABMOdGZ
	dCffMyHXVQgAAsFBz3DQtskscv4krBRLcGglIccmvldnyFqKIVd1+b+L8Mz1ZB9G0heHJShZvLu
	LCoHpNDZRsYhE=
X-Google-Smtp-Source: AGHT+IH1z8kfADwO2bnvxHtlNrXdx7wo1uNElAIwlN1P/rRWODDEB5ajY45E+Y9WZ06y3PnTv5AphA==
X-Received: by 2002:a05:6214:f04:b0:86b:9167:b0e9 with SMTP id 6a1803df08f44-87b210576bfmr422647886d6.4.1760483566332;
        Tue, 14 Oct 2025 16:12:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87c012a1cdfsm6812466d6.49.2025.10.14.16.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:44 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:44 -0400
Message-ID: <8760514587ca702853a22fb51e9c9bd7@paul-moore.com>
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
Subject: Re: [PATCH RFC 4/15] Audit: Add record for multiple object contexts
References: <20250621171851.5869-5-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-5-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
> An example of the MAC_OBJ_CONTEXTS record is:
> 
>     type=MAC_OBJ_CONTEXTS
>     msg=audit(1601152467.009:1050):
>     obj_selinux=unconfined_u:object_r:user_home_t:s0
> 
> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
> the "obj=" field in other records in the event will be "obj=?".
> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based
> on an object security context.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h      |  7 +++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
>  kernel/auditsc.c           | 45 ++++++++---------------------
>  security/selinux/hooks.c   |  3 +-
>  security/smack/smack_lsm.c |  3 +-
>  6 files changed, 80 insertions(+), 37 deletions(-)

Similar to patch 1/15, dropped due to this already being in Linus'
tree.

--
paul-moore.com
