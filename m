Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642F42E42B
	for <audit@vger.kernel.org>; Fri, 11 Sep 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125865; cv=none; b=mwKOroccTZhkDkKqJo9MLxOsBofUn8XO2lLbnbOnTalKM/Ulhssstm1p8/zZowS6dnumqHrK5qGulrop2qgzCg46r+Xk12uLX+Vqif44YJ99t3gnj6TLfmll5YV7cOIIvf3YUkQWi/ec2PPOfhmQtFTd9G0ShVWD/Kw22FTvujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125865; c=relaxed/simple;
	bh=dTfnOyCnA7hxdwn+lzetAiaSH6DRBFI0JNJ4cyWnp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB0lL6QR7a4Fx5BBYFJ7ekmQM5yuUHkUsNdP2fmrU9eGdoA2NfwGabQyPZBE3HHS33haEIdL9bJrox6ZPoAq5skboThuTqvOprSsh+QEDW5krY+XDANRiMlqVVGitfMQ+urhMW2ad7Rl5WqN7b3YqUV2/iAp4ijhnUufB8DFmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Abhg5kEP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Abhg5kEP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so9940055e9.0
        for <audit@vger.kernel.org>; Fri, 11 Sep 2026 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789125853; x=1789730653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yxMwJEm7jTlZ/4MOIRCMOFi1PHLu4xK9k7RvriEL/cs=;
        b=Abhg5kEPlOZzz61wXw4oP9rE4wPA0mEaEzF7lShaceq7q3ZH1UerVQTWGIrm9A9JhF
         gvTuvkzoFoLJCk2yyIhu+dEs8i9bME3TIT56nmYwsFKs6eqlGpmnToBV8bvLgWBy6D+M
         FfnHwFNlIGl203Wj/Gizw2PLW5QFURhLXASolY0RSLnKPIbniz8SSR/nez3cGGGCpjnt
         buTJN7EXDu/2BIDNBjzfhDCRTVhJbDJGTIAb+an+GPlDN8T19oElChX/QTCRdLNMHrat
         VOqeWiU6tRB37wZKIPvHR/GpbtOmqI03p+49k1sYadnYPnROweYxZIhZ7w0SojTH2hBt
         KB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789125853; x=1789730653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yxMwJEm7jTlZ/4MOIRCMOFi1PHLu4xK9k7RvriEL/cs=;
        b=MgAQLilzkf7+OZsJpFypaRkW5wuVFZQ+qzvp77UGMorXuCo2QKjTo5CshbwbZjLgjL
         6p6GVJwrZ49d7Qtuil2gHFjgLCM2EjbzVvWGl1iQ4dAvzel8aleDpsu9wKcHm30H8O9j
         rXk3jz3FlEMnVUsIvNS5tpaI33xY+jl5iVfslF/2Q0MIFJqTTNaV/R5Otdj+JJAQ4eaq
         sWkm+YuCo617koCLpkUTtt7uhqPk4e+PqIflj0sH9e8jQJfYGgJ+UjK8RggxdqhvC4YK
         h98T5JlVaiyBjYKHtU3Jdg6OM6ba4qvDQwr7eTOpOt5f9LazZCElIwyOZNyp/BbVAM0k
         Ax3w==
X-Forwarded-Encrypted: i=1; AKwUvBzlgU7mKSr8tX/qNENHI+5tHbjKMaOmZDv1jKj9o4twGzJ6DNH2CFKVyg8ZoSQANj1gaH1q/w==@vger.kernel.org
X-Gm-Message-State: AFuF++m02WICKR54ckr04UUNdnFP8AH9pMSEPICcxm4RBI3FBqqGvYoy
	q17BEPi/VjWQImUIXomQEgV50GR6eX5nKnxvd3puYn2hyBTHL16oubXnblWdLlrBkw==
X-Gm-Gg: AYBFou2R9t2M0Z44O778NkpRGfnCG/1jYUe1MhSpo82vNeIsZBBGjbjJK5XRLmJqnd7
	nXcYKHX4HZSOKW2Xq/tDikSCkxXbQ5DH8P2uiEFWVGTbnCbqngSO2UZp/3wokPjk/3VSRwMPjqw
	6UAbPJsoZRhoMQR29bmtYmet15gXhdUPnSw/SHcQgkfsmfdxtsEzX+0d6iDmWs3IwuYRQrX2wbx
	7V+go7Vk+pq63CT/XnSfcXGSy1eVOeHRIW2qN9OeJw5dKo9AXpjk/YUtyu1vSpmGqvAJ37WP05a
	JaUVWBXa/EM6rllFhgor/aL8X7RKG5wWuIOY2f6JdF6GVM/+DDb6PFN0oE4LYdyLjbhDraWB8fH
	qQK/sDzWjP4Si5sRb2IVQaMUkvfk95yBQO3+m2kiqdABxdYhU8QukW7CxjmmJ2upQxCdQi1NySB
	kU24SgwmM3cyblDObfLWHp7iVSYIMpIveUnE5C0sUmbEKscXqtd/CsfaSMO+pOMWk+HbyXENRFr
	boGK3DKWlzaxDXq0qUKwCi6HgzoGQ==
X-Received: by 2002:a05:600c:6309:b0:49c:ff3c:973f with SMTP id 5b1f17b1804b1-49e619c45f9mr37913425e9.24.1789125852560;
        Fri, 11 Sep 2026 04:24:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:9f0c:8f56:41ab:6c3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60acff8bsm68594435e9.9.2026.09.11.04.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:24:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 13:24:07 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Jeff Vander Stoep <jeffv@google.com>,
	Nick Kralevich <nnk@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	audit@vger.kernel.org, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in
 audit records
Message-ID: <aqPk1ytxErNcqPuQ@google.com>
References: <20260910144837.381855-1-mic@digikod.net>
 <20260910144837.381855-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910144837.381855-3-mic@digikod.net>

On Thu, Sep 10, 2026 at 04:48:34PM +0200, Mickaël Salaün wrote:
> The ioctl audit test uses FIONREAD, whose command value fits in 16 bits.
> It therefore cannot detect truncation of encoded direction and size
> bits.
> 
> Use an architecture-independent unknown command with set upper bits and
> require its complete value in the audit record.  Landlock rejects the
> command before the device handles it, and the existing ioctl enforcement
> test already exercises the same request.  The new expectation fails with
> ioctlcmd=0xfeee on an unfixed kernel and passes with ioctlcmd=0xc00ffeee
> after the shared audit field is widened.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 18dbdb99aeba..1abdcc9ee784 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4146,6 +4146,9 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
>  	ASSERT_EQ(0, close(fd));
>  }
>  
> +/* Arbitrary command with nonzero bits in both 16-bit halves. */
> +static const unsigned int unknown_ioctl_cmd = 0xc00ffeee;
> +
>  /*
>   * ioctl_error - generically call the given ioctl with a pointer to a
>   * sufficiently large zeroed-out memory region.
> @@ -4249,7 +4252,7 @@ TEST_F_FORK(layout1, blanket_permitted_ioctls)
>  	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_ZERO_RANGE));
>  
>  	/* Default case is also blocked. */
> -	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, 0xc00ffeee));
> +	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
>  
>  	ASSERT_EQ(0, close(fd));
>  }
> @@ -7943,6 +7946,7 @@ TEST_F(audit_layout1, truncate)
>  	EXPECT_EQ(1, records.domain);
>  }
>  
> +/* Checks that audit records preserve every ioctl command bit. */
>  TEST_F(audit_layout1, ioctl_dev)
>  {
>  	struct audit_records records;
> @@ -7952,10 +7956,10 @@ TEST_F(audit_layout1, ioctl_dev)
>  
>  	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
>  	ASSERT_LE(0, fd);
> -	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
> +	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
>  	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
>  					  "fs\\.ioctl_dev", "/dev/null",
> -					  " ioctlcmd=0x541b"));
> +					  " ioctlcmd=0xc00ffeee"));

Minor: I don't see much upside in extracting the shared unknown_ioctl_cmd
variable here; if we used the 0xc00ffeee literally in the
ioctl_error() call here, it would be clearer in this test how the
test's stimulus of calling ioctl() with 0xc00ffeee related to the
expected output, without having to do that side-lookup.

Logic looks good though, good to test it more exhaustively.

>  
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
