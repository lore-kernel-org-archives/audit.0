Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961051CF7BC
	for <audit@vger.kernel.org>; Fri, 11 Oct 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682475; cv=none; b=hvEKuNwMM9rxtZXuO93ArHzXAPzDCDDb4phBb8eCkmYeylMtCqf25CnnkLINnEpG3L+1UDQZ5D+AQ0cvuJJLz/QGxCyfj/GuZme++jpi1aMFUTJfHT5vsadHd2Vi2nBhLFfeXdbj0KSV/MjPaYMHct98lb6jqlhVuzmA9KB5CV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682475; c=relaxed/simple;
	bh=yn68VGQgjuF57lFPHzPET93dI/gFBtZI+3oFtACRqdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMEHwOL2U7Tpdost+EJm/NN4NQwUg7vl/mI7/jO5a6MQ9KQMHAYDLU+iE21p8T2lGrUD1OeqDXt4Bwn9W1zP4kAkYk3rs3W37wSQm3IZXU3GOmY31FHGBGTeYfR5kMW3zvaNc6phGR4JdTB2hRisqcWD3zFSepkuRQwyjRpnt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=caijQmlS; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="caijQmlS"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso2644263276.1
        for <audit@vger.kernel.org>; Fri, 11 Oct 2024 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728682471; x=1729287271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=caijQmlSLH6Mn6V9Bh5OtPmtrih6HODYry4AeeeOsNhI2lrdPj2P8CJcgedFPsFYnN
         9grM3LwYNldCHZawBfBC10tYjsH23tLkAMx86mX+dkgE/7e0mGpcGu+7U6E2HYBrdDqc
         dCUzZ3/4GQ30K5F4OsU9m1jbcF9YnVModAx/RdB1tIaYXbyt8LZw/trWf196QbIMkTnU
         +1hAWpqaXYsMBAw/4J1C3dOhLws2hKV12prYbtqY4ylJhHI4VlkhXU68mqDD57X/nicz
         5MGJjVhgKTGNyRIYt9DQCOTQxOWlOG51E3SVBTY65E8s19rVFXbYAfSPcJ3MiO3PJW37
         7lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682471; x=1729287271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=AexLG0tq3penCbHHUcJIFg1JJQ2J1bsb5fuL0lPb+PUcWJmO0fl21k6ZLzBoNPMWMF
         L1rn0Y/GZPuz5S2DqNWxIEUEG678qWJ//92XLDImpMOiQpXgiRPsBZOQSwRphSINMJv4
         IT2TWyfYAwlYzv1Cs1/QkuflAFpc2iLqJfKNEIv1+nUO6icDdBfCCG23uqWAVY8+SE/H
         0oi7ctU9lLgRz03GhhuGnNglqaJWxU2H7VR66GIYdvOgUEYwCX/GdCctsQiJgs9U3+tc
         oIcUwq+AD+DdoQh2FEq6ZRQICsKFQn3xGlqDJudz1/O793TYWj5acXJQcc6jit8mzY/+
         2iPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkdYQ+WS98kIyBSQJYTB5v+P6rNY2WCuslPZLy3xAuBo5J0HNbo/8XmZoJjRy7tBq/iZ1bFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Nlh6VZGAoKqYaQ6zu4u7cJ5kqGbQIWP0lZ9GH224dthh6Qcr
	IcS0A39oXBHvXzgSsApCSsFZhI/W/e05DTOYSrhWdMXp8jX3t1gnqFD2uuAf2g/iVtzNrUvOuZH
	3vC6qoOx3GOku0/Ti37fiJa9TF2c+7/EFqyeK
X-Google-Smtp-Source: AGHT+IFrYhiJio4X4+ywyBra47qcZ6SUO4xvjf/kfaS0SLCEASRbGZElMMGFLK5PU9YPz4TciK+hv+7VEGUf5UKSZ1k=
X-Received: by 2002:a05:6902:11ca:b0:e29:18e2:622c with SMTP id
 3f1490d57ef6-e2919ffb611mr3143224276.56.1728682471609; Fri, 11 Oct 2024
 14:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 17:34:21 -0400
Message-ID: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

While answering some off-list questions regarding audit, I realized
we've got similar issues with audit_name->ino and audit_watch->ino.
It would be nice if you could also fix that in this patchset.

--=20
paul-moore.com
