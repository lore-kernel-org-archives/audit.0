Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C433B966
	for <audit@vger.kernel.org>; Fri,  6 Mar 2026 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767358; cv=pass; b=MhqFinU5MU05ZL1nNsG8o6naqUGy1g9Tc8/+g+BSH9r5M+3G4Kn+BiLAlawdranydQcreL85nSO67TELlhArrG0pjXpNUCZ+1rQLiw+Qw78dQQ3x/O3i+X6KBCHRFx2Zb1+LNJZx3C77gb3HyIEckzu0JAum2/4IPPs1Fe2WZuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767358; c=relaxed/simple;
	bh=ko5d0I3UoH1kqBdHjhYIOZdUk/RiWoMQOWoVYZ8nkwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THWNhnndTfqEc37wV7KR8UzmtBDRG/4Ch0024Us2KjeOwTc8EZ7RcA006vclZQBqCukRrXJhoPc8//ZCV6ajMkr7t2U6Kl7yED/lMpaQLEAMTPod+WlPL1ho6+HVg35TZmu8E08RcGXKMhVE97e92mXpT1GmMCzPGo2/jO8ECIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D/OFQe9k; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D/OFQe9k"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c739561f0d3so713469a12.3
        for <audit@vger.kernel.org>; Thu, 05 Mar 2026 19:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772767355; cv=none;
        d=google.com; s=arc-20240605;
        b=I+w+5BhakMIxAv0tqU38d8z7sB7/OzciWYNiG/CY0hID9e0Vu/k/6Crum50m8TAcCV
         hfH4DwmUm9yK3iRlMzap7PSEuGyu3pWo0r1ILAPn+C7DWERd5Q4bCPVkNwP7z3TwsAgf
         sNbBSKLtgPkMyExg8AXUw2JKOffEA6pfQNNLzqlszXUDS6m24U7qkw9J9RbNJzaYwMNK
         uyGQnyQsGrjKdtzigU4ZtJ4PoajIoYSDypC0RCadW3zuldCqqguXWy4u5ps4CKqz6m7K
         qfFdQe3qzFGcsPqPPj+vygetW4DqxeGw7e/mVvqEmI7yRm7NFw/rhkbSar8tI4T0SSwy
         UUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSDOQCkuzUJGm48OvufMbZR53pd61OWRu4rMaXpnteM=;
        fh=9YiDhQQuGtXudNzVj0W9t/0r91nNppahqdMj9yS/MS0=;
        b=YWgdEKJqhQD4kLdjigD7cImv1Zsvc2f8OWguM3Tfo63NozC01g9qYoAvlrdk01LgX8
         0cImsHSqUuaErkaSrGH8sS+TGEivj08uAb052CVvKQ7ZtrWwPhMqGmq6XWynR2WEvxYE
         +jZmnXXtL37485HI100PV7RPXHQsvM+7RQB9WahrtIo6yVHtBMv3ytxxNuvxU2Ool5oK
         cLuU+ZQ+X6f3Q9xkstVcrpW0WXVOjKimcXRkLHJu2CZoOEenO9UoFoZ8APwlN7yb7O/5
         IaMaEeT3kwoXBdyCpsQghEcw8MHSsxyTqMK17zHYnvgIawl2LFj2KVn0B+aC+oWFavwq
         aSwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772767355; x=1773372155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSDOQCkuzUJGm48OvufMbZR53pd61OWRu4rMaXpnteM=;
        b=D/OFQe9kxCQE5/MWK/2q8+95TSKCODqiIpg5NTGhE4tfteHwunPb/J7ez6KmKxtbca
         8Oc9RC2mKfNrZhe8k2Cz4cSbrE+MR6rgi9t0yKQNv9psTo+9lBDIqcq51ftMsFXYu9Kq
         cMEqvHKewcEZsR/6n9taqZXZElfMGyPte3x2FodVlaz2gDxHNTwsTmzbJ1QCeUaN9n4U
         /poRwL9fZgetu82tsyEzH0AaC4If5StrBOb26VQ4Vx8QNLDLyRGqHRLQduWxaCtCN3pw
         UhKrCNNq5mcsnYA7hQxizZelaift2CfTGfD4uxqh6/nEKlW9/0L6qpZhdmU7Ln+u6tgT
         zX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772767355; x=1773372155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jSDOQCkuzUJGm48OvufMbZR53pd61OWRu4rMaXpnteM=;
        b=EjgzbUbORfJqdO3pK515Vt8bLBNUET6jdYxTlSAdYJEmrw34kHt+mm+fu0P8xWFGnN
         RopW4lhX/FE1jm4VQPFBEzIGkSJ3nfzcS3HikMo/9weFTXfoBc1ctIv/7b+UgTlZBTGw
         MxWuyCQwlP40Pdh8WzAfSKD0iwct4N968uvtJTZYO52C6xG1EFtSa+6rlOUe4fHyB4b4
         OmAk6RlywehaoZ6n74JpGEPkUEWcLifRmCVRrMY1Va0FT1qZ1He7zby9jRch8C4G7697
         5ptJZCJL2eygpthgGQUegiCEMCEgnANOR2M6LwYL6cvepfyq1PaTXT0GWmtYgeoiDXwH
         hNAQ==
X-Gm-Message-State: AOJu0Yyo64JLIL1C26tTUKkCDV5H7U7gqhaYMFnb1VVaWzKbDF67U4W6
	Mh6uC25GBHbFNSU7Q0/cOL1BUKLVj0ht1Y1mdXaKhMuh6Kr3Y98aBIgCHefnCfJFrRdVtMVKgm1
	kUHru4qn6oDFaKDpMuAO665di+NKNwXlPaJjlag7j34XW37VApcKHEg==
X-Gm-Gg: ATEYQzxQ4N+EfkQZrejtYJ6O8vwlmK70XXB8i5W0cmaGs/AXRkP/ApkL5n8kYkg+FdK
	ApUPMtLqwOa87958YpSl0uxgWNx+tswI5bOYg77O8McU1ZQX+YGTCvnIOCbEjb7iocwj1GwbzdW
	yr936aZ0NfS/S9beEVcDhcNqkybp5ttUcsCNUbY588XvgppkT/le+Ce4/y9hI5c9x0AVeeDx8uz
	74h4HYrcFPnKYqb9NhL2tBu2u+Fe9td+t057iB97viu9NjRZ6IGVJa8iOGo1wLVMonxNzsBhJPV
	jCNM4eg812nDhznPEw==
X-Received: by 2002:a05:6a21:6b0d:b0:394:56ae:8a7f with SMTP id
 adf61e73a8af0-3985908ba31mr925388637.42.1772767355196; Thu, 05 Mar 2026
 19:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303124229.700524-1-rrobaina@redhat.com>
In-Reply-To: <20260303124229.700524-1-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Mar 2026 22:22:23 -0500
X-Gm-Features: AaiRm53QwP8BitUPW76CbRlAi9IH1qFmnoIVPfYYfhJ131hdlCyz-qlZt8pub7Q
Message-ID: <CAHC9VhTHLfM_-ibaz-DK3VhaLHkgvM7Jo49OQ6up_dqWERUH7g@mail.gmail.com>
Subject: Re: [PATCH] audit: handle unknown status requests in audit_receive_msg
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 7:42=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> Currently, audit_receive_msg() ignores unknown status bits in AUDIT_SET
> requests, incorrectly returning success to newer user space tools
> querying unsupported features. This breaks forward compatibility.
>
> Fix this by defining AUDIT_STATUS_ALL in the UAPI header and returning
> -EINVAL if any unrecognized bits are set (s.mask & ~AUDIT_STATUS_ALL).
> This ensures invalid requests are safely rejected, allowing user space
> to reliably test for and gracefully handle feature detection on older
> kernels.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/uapi/linux/audit.h | 9 +++++++++
>  kernel/audit.c             | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 14a1c1fe013a..1d5122b9274a 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -356,6 +356,15 @@ enum {
>  #define AUDIT_STATUS_LOST                      0x0040
>  #define AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL  0x0080
>
> +#define AUDIT_STATUS_ALL (AUDIT_STATUS_ENABLED | \
> +                         AUDIT_STATUS_FAILURE | \
> +                         AUDIT_STATUS_PID | \
> +                         AUDIT_STATUS_RATE_LIMIT | \
> +                         AUDIT_STATUS_BACKLOG_LIMIT | \
> +                         AUDIT_STATUS_BACKLOG_WAIT_TIME | \
> +                         AUDIT_STATUS_LOST | \
> +                         AUDIT_STATUS_BACKLOG_WAIT_TIME_ACTUAL)

Overall I think this is fine and good, but AUDIT_STATUS_ALL doesn't
need to be in the UAPI so why don't we move it to
include/linux/audit.h?  You can put it at the very top, right above
the AUDIT_INO_UNSET macro.

>  #define AUDIT_FEATURE_BITMAP_BACKLOG_LIMIT     0x00000001
>  #define AUDIT_FEATURE_BITMAP_BACKLOG_WAIT_TIME 0x00000002
>  #define AUDIT_FEATURE_BITMAP_EXECUTABLE_PATH   0x00000004
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 5a0216056524..592383dce090 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1295,6 +1295,8 @@ static int audit_receive_msg(struct sk_buff *skb, s=
truct nlmsghdr *nlh,
>                 memset(&s, 0, sizeof(s));
>                 /* guard against past and future API changes */
>                 memcpy(&s, data, min_t(size_t, sizeof(s), data_len));
> +               if (s.mask & ~AUDIT_STATUS_ALL)
> +                       return -EINVAL;
>                 if (s.mask & AUDIT_STATUS_ENABLED) {
>                         err =3D audit_set_enabled(s.enabled);
>                         if (err < 0)
> --
> 2.53.0

--=20
paul-moore.com
