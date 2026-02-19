Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26312F5A06
	for <audit@vger.kernel.org>; Thu, 19 Feb 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539275; cv=pass; b=bOcwlhyIMN/0IYM6SwcKpXCti+rkbG5aOl0bc8Au0WlwoAUc7M5xJT98m0FInAObpdQW3BRAzgR6XyxnLox0sV7mI7VUW9CQ4VIa+g8ulKUiFpnGmwj5cVsg4xYE8tWzvQVfYzdsJf3y7yaFdWhlgrq0gaR3d+TAlt22AYUzHLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539275; c=relaxed/simple;
	bh=JpGwHvT/3hhwHza/ym7K4teVN7Fl9ZYoYYQm9v2aG84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWDE9+Jx/BgnWuNYR+3aLbM4WCj9elF//xn3SJ8PLvX+BUJJhIy2XJqBhHo07YGOSO88EwbjDefZYZ+9LT5riSceUowBqs4RnwTw63D67k0vfGrAEtBmhSpPdudHxD299pFE6hxBr5W6gwynKQERRgH0Peh6ZZCyCSHc1ncTK2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gBWwAYZ0; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gBWwAYZ0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a8a7269547so13957235ad.0
        for <audit@vger.kernel.org>; Thu, 19 Feb 2026 14:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771539273; cv=none;
        d=google.com; s=arc-20240605;
        b=F2i2i5hIJ9F+SADaEMxIumHBJb0yB49slZPIKbPRorJcqx61/c6gzMq8sjGeRiZ8ws
         hDuDKt3sEYWjz8y481WGlnwYyL+3su4jBF1knsjP2D8zjETduMM/XRmXGeJ6Lvyo3yW0
         PLjDKSJI+7eijmddp+6Q01ePvpcjv6lVphyvWqFfrkUrUZ9U38x6RNKt4DL+SFht/KAd
         rfeBOcGYxEHB87GDyAOZ5MUO2FZdSP8vnOqn1NxTLHgAv6f/XHIOpVCVV0rklS1gY6pn
         vCkfcGCw7/9UiVWRyQKzGovsKiwpzfz1nmJgP1zc2f35p38kWmO2BRhyQu0ykXnQfT1r
         mPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuWksm/z64CkDA8wVi+HNFlxh1fV4OvGcIJUKwatE7Q=;
        fh=tOlJCInf3pImKYTkUCl9mAJxaD0YIg5bIhQNCjmqfKs=;
        b=A6pSngWVZD9EMK5MXkj4XaQMt3bEjYxVGLu/gsTklpJ+I8usMSkrXuf2gtnyozWqrv
         yHO0UxTbJyPgDXnFszZ1y65o0Scw8WZUxN2WOHwShf69i7c6DUGgN8xdzeIKu0/rfEu+
         E6D3/peYcBLLf1J4qURKkg/Ypn1cVdiYeNbaYaqqc2IEWsq9yVdNbaNFyT5omX7WMTT/
         pr10tMZ43d27Pp2pNrFQinZDP8C8npVO544X6TeBsYFu8pRlubL0Kkgc2BjPsHq1GuxS
         BcUhB4yrSJcbO85fCpemT59zOrp19APZEt0fgmHIrj7wN+DCeKtBP+iVUZ5ZoKWug8bA
         xLsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771539273; x=1772144073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuWksm/z64CkDA8wVi+HNFlxh1fV4OvGcIJUKwatE7Q=;
        b=gBWwAYZ0NP5c3k5eI5W515q4ZiQjAQP1NluNSOYuZqTBbJALLybWKFllVjM/OETrOx
         w0jq0m/2fgHr3miMYFt8V3LK5p8OLlEs0zzgO56uNNSYFo+tthN50AgUzXBApG3DK/2D
         F6hU7WKMiEaTyo+HvjkU1VJvO/Yn6CQYTeogqhOkE/GpJ4kAOzYx6hwwGOtmS7+vKxB3
         PNU9OH9ERxX45GFrHebMN1ga+tnJivwoBeWRGHTogINlY7X6UijK36d4OzhOuWMvlsew
         F3GLTc4q7soZtQOZ6uR+jF+bbYOxCOaLTTpHeFOCf6hNfYGZhkEKCnuPoQdMFViwaTun
         pyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539273; x=1772144073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuWksm/z64CkDA8wVi+HNFlxh1fV4OvGcIJUKwatE7Q=;
        b=a1wrOBVLaRTQqXlnoz280Y8RTozj/aX6ipEa0l+bEN4m+psUy/4yT0QzRX19SvtdzX
         o3PKXuzjmxoj//Aumen9Wkl8tllVQoDrHyv9mJhJyxmYghiNoeYxpf5yMJE4YRiclL4l
         p9kaI0h1+cMDSJoQRPGBvYVmPznyy/CfvgCJEMJMtmw/PgwbyWcnCFOGJZ9zf5LdqZ/h
         RMh2HVjLg0c9Oee58CHp9OSnIOHVgOm4ow3ESjwoUYkZuWdU+/ljLb/W7ZoE8utirDvr
         ACMfe5CjdSLe4jP/lJVwjPNuzacS0KLaiKSJs9eslqo1wvhRPdLj059Af8R54Ue4DqBI
         Wu+A==
X-Forwarded-Encrypted: i=1; AJvYcCVStf+ferlSEaIOAkpvxN71PksR8vok42HiWyhuSvuWcvxsMEyaU/XVJH9ITuWWT0ybvmDq9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkg3WJXhFR/VisYndomb1Fvu5Q8IL9NsUAnjJi3MzrZJmD4ISh
	tf4w4NIb0cmSV4jfr5YnPU7QDk91DKQGApMKPgbv6RqBRWi+XyfL6zFfUoKkyQHQBPkrsEYXXSA
	yojGJSB4uDDG2CNpc/IGteNzKLOCZzbj+PDfM7t+D
X-Gm-Gg: AZuq6aJLRN7LbubluLZDSGRhv3K0w0KbzUFCF5VMokkDon3wE9oqcyVThK8+Cjrhdl/
	duAmyAN5lqYkdYJ869EHHPyDYkPbSMqtQGo8PwxPPNxS8rYh6qKrreKma06XzRmQzj017ln1Tqo
	GqeGg+9Qa0odZe0SMBT8kwfr6Ysu7LYfLLtBIYqVmxblWVIdm/RpbTxWN9QDzempuIsHAGe+mca
	hUo691jm9CeFaWgeqHhxu4DwFaqV823h9uvu4hp/7uAHKFbzgA/a1zli/lbBG5AzMm43GygZmWV
	C6k4Z1k=
X-Received: by 2002:a17:902:d545:b0:2aa:eaa7:2a9 with SMTP id
 d9443c01a7336-2ab4cf4f959mr206906725ad.8.1771539273002; Thu, 19 Feb 2026
 14:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206201918.1988344-1-longman@redhat.com> <20260212180820.2418869-3-longman@redhat.com>
In-Reply-To: <20260212180820.2418869-3-longman@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Feb 2026 17:14:21 -0500
X-Gm-Features: AaiRm51RDgNBu0z7rNLTqXSyUOVNwxPkgUEsGNbLDaPD_6KPUkH0zhu8FG_KoSI
Message-ID: <CAHC9VhQXK__Qbyr3TXF5gjQEhRROkOtva3nPZhp7YUy2orgj8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] audit: Use the new {get,put}_fs_pwd_pool()
 APIs to get/put pwd references
To: Waiman Long <longman@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 1:09=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
>
> To avoid this kind of performance regression, use the new
> get_fs_pwd_pool() and put_fs_pwd_pool() APIs to acquire and release a
> fs->pwd reference. This should greatly reduce the number of path_get()
> and path_put() calls that are needed.
>
> After installing a test kernel with auditing enabled and counters
> added to track the get_fs_pwd_pool() and put_fs_pwd_pool() calls on
> a 2-socket 96-core test system and running a parallel kernel build,
> the counter values for this particular test run were shown below.
>
>   fs_get_path=3D307,903
>   fs_get_pool=3D56,583,192
>   fs_put_path=3D6,209
>   fs_put_pool=3D56,885,147
>
> Of the about 57M calls to get_fs_pwd_pool() and put_fs_pwd_pool(), the
> majority of them are just updating the pwd_refs counters. Only less than
> 1% of those calls require an actual path_get() and path_put() calls. The
> difference between fs_get_path and fs_put_path represents the extra pwd
> references that were still stored in various active task->fs's when the
> counter values were retrieved.
>
> It can be seen that the number of path_get() and path_put() calls are
> reduced by quite a lot.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/auditsc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Apologies on the delay in responding, I had limited network access and
it looked like you and Al had this under control.  Regardless, the
audit part of this patchset looks fine to me, my ACK is below if Al
wants to take this, otherwise I can merge the patchset via the audit
tree if Al ACKs it.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
