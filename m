Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qyf8U6CM"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F21A3
	for <audit@vger.kernel.org>; Tue,  5 Dec 2023 13:25:28 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-67aa0f5855cso16234486d6.1
        for <audit@vger.kernel.org>; Tue, 05 Dec 2023 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811528; x=1702416328; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybenO6JKKRDn6ftSruJGndBQsEtDe1upMJA2JO+7HT4=;
        b=Qyf8U6CMRJ2VOaNQKCe6e9hnEskS49HNekAAEkfKBfje0xcXvlPTjAR/IsZJgsWDJA
         fyrIIDSvQ6zD8rkd7BQL1tcvpPSn/UJxtZvcbFz/BlpeYKa2/goXkNb5O1Zkf9DRlkA+
         11LgiUjFJNIvodNBtE17IJ78im3e5unPlEYo/D8oxtV22gt8C8IbWJJE+ViN1aLxyXZG
         2AThNTHDjymkQtV7g5MzVA5kdREFW2gbT00HpXCaDGm8nK1QwSy59Jo0ZKpI0PgzDNJj
         NxjkBf35jNPkNaRrqNGLYUatHFrHTDqaPbxGuU2+14NnAaBWHkQvpZrNulGFITjjVNQ2
         IicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811528; x=1702416328;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybenO6JKKRDn6ftSruJGndBQsEtDe1upMJA2JO+7HT4=;
        b=kJD/q8b2WfRyZ3Avw1d6FQdILubOS/VtTOR9NQvlGLrdM91Z6MYSg8dntuAwKy4IJh
         pKatZv00uCv7yL8Yx7ulT4Ueke7jD05dONx8ZdOIjF5z1JrJp0A029T5GCVtdJbqHn02
         Bx6Q07LvvkWkoDWJS6Fuk1567VJjqPpqEXpJNvDLTfaldTz/xlL7uT9RNRGq8XA4nMsu
         Eq5LAyND/pyOrZsGCCCKMX3OxUTitzEaDbb+Htu7akmm3PrXF+ouR6wC7/rn2+Em66HN
         KixUmh1yd+ShCNuh/vUpJ3wNYxzZkOZjM5QHiIBbXAdwJXiKvFuHVWe10BRGO6EWB/QV
         FaZg==
X-Gm-Message-State: AOJu0YzjU8OBc1upe2Yy7GqIV3ZQPI17I05mxoR2JynqdmnX/PCnVWox
	R5Ru7ckdRbd8IKO7dThmK+6o
X-Google-Smtp-Source: AGHT+IEVTa0Sf9/RsSghdfc3Hbu4qPY84/gjX8Nyb16BAKIZBRdfJ20XSDr5Bo6Wx1zoYLWQH3+ZIA==
X-Received: by 2002:a0c:e84a:0:b0:67a:dadc:db3e with SMTP id l10-20020a0ce84a000000b0067adadcdb3emr1665894qvo.33.1701811527751;
        Tue, 05 Dec 2023 13:25:27 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g3-20020a0ce4c3000000b0067ab7eada1dsm2719307qvm.59.2023.12.05.13.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:25:27 -0800 (PST)
Date: Tue, 05 Dec 2023 16:25:26 -0500
Message-ID: <f3f08ce6b3b273bde1ce6eb41b0ca3c0@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, linux-unionfs@vger.kernel.org, "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: Re: [PATCH 3/16] capability: rename cpu_vfs_cap_data to vfs_caps
References: <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-3-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

On Nov 29, 2023 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org> wrote:
> 
> vfs_caps is a more generic name which is better suited to the broader
> use this struct will see in subsequent commits.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/capability.h | 4 ++--
>  kernel/auditsc.c           | 4 ++--
>  security/commoncap.c       | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)

Bonus points in that the proposed name is shorter too :)

Technically you'll want to get Serge's ACK as he's the capabilities
maintainer, but with my LSM hat on this looks okay, and is pretty
trivial anyway.

Acked-by: Paul Moore <paul@paul-moore.com> (Audit,LSM)

--
paul-moore.com
